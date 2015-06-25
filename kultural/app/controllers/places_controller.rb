class PlacesController < ApplicationController
  include Foursquare
  before_action :set_place, only: [:show, :foursquare, :edit, :update, :destroy]
  before_action :owner_of_place?, only: [:edit, :update, :destroy]

  # GET /places
  # GET /places.json
  def index
    @places = Place.paginate(page: params[:page], per_page: 8)
  end

  # GET /places/1
  # GET /places/1.json
  def show
    @comment = Comment.new
    @rating = @place.ratings.find_by(user: current_user) || Rating.new

    @hash = Gmaps4rails.build_markers(@place) do |place, marker|
      marker.lat place.lat
      marker.lng place.lon
      marker.infowindow render_to_string partial: 'events/list_events', locals: {place: place}
    end
  end

  def foursquare
    response = get_place_info(@place.lat, @place.lon, @place.name)

    respond_to do |format|
      format.html { render partial: 'foursquare', locals: response}
      format.json { render json: response }
    end
  end

  # GET /places/new
  def new
    @place = Place.new
  end

  # GET /places/1/edit
  def edit
  end

  # POST /places
  # POST /places.json
  def create
    @place = Place.new(place_params)
    owner_info = params[:owner_info].split(':')
    @place.owner_type = owner_info[0]
    @place.owner_id = owner_info[1].to_i

    respond_to do |format|
      if @place.save
        format.html { redirect_to @place, notice: 'Place was successfully created.' }
        format.json { render :show, status: :created, location: @place }
      else
        format.html { render :new }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /places/1
  # PATCH/PUT /places/1.json
  def update
    respond_to do |format|
      owner_info = params[:owner_info].split(':')
      @place.owner_type = owner_info[0]
      @place.owner_id = owner_info[1].to_i
      if @place.update(place_params)
        format.html { redirect_to @place, notice: 'Place was successfully updated.' }
        format.json { render :show, status: :ok, location: @place }
      else
        format.html { render :edit }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /places/1
  # DELETE /places/1.json
  def destroy
    @place.destroy
    respond_to do |format|
      format.html { redirect_to places_url, notice: 'Place was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_place
      @place = Place.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def place_params
      params.require(:place).permit(:name, :description, :address, :lat, :lon, :picture)
    end
end
