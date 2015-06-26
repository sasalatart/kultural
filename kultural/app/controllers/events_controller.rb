class EventsController < ApplicationController
  before_action :logged_in_user, except: [:index, :show]
  before_action :set_event, only: [:show, :edit, :update, :destroy, :attendants]
  before_action :owner_of_event?, only: [:edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.paginate(page: params[:page], per_page: 8)
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @comment = Comment.new
    @rating = @event.ratings.find_by(user: current_user) || Rating.new

    @hash = Gmaps4rails.build_markers(@event.place) do |place, marker|
      marker.lat place.lat
      marker.lng place.lon
      marker.infowindow render_to_string partial: 'events/list_events', locals: { place: place }
    end
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    owner_info = params[:owner_info].split(':')
    @event.owner_type = owner_info[0]
    @event.owner_id = owner_info[1].to_i
    @event.event_type_ids = params[:event][:event_type_ids]

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    params[:event][:event_type_ids] ||= []
    @event.event_type_ids = params[:event][:event_type_ids]
    owner_info = params[:owner_info].split(':')
    @event.owner_type = owner_info[0]
    @event.owner_id = owner_info[1].to_i
    respond_to do |format|
      if @event.update_attributes(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def attendants
    @users = @event.attendants.paginate(page: params[:page], per_page: 8)
    render 'users/index'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :description, :date, :price, :place_id, :picture)
    end
end
