class RatingsController < ApplicationController
  before_action :set_rating, only: [:update]
  
  def create
    @rating = Rating.find_by(rateable: @rateable, user: current_user)
    if @rating
      @rating.update_attributes rating_params
    else
      @rating = @rateable.ratings.new rating_params
      @rating.user = current_user
    end

    respond_to do |format|
      if @rating.save
        format.html { redirect_to @rating, notice: 'Rating was successfully created.' }
        format.js
        format.json { render :show, status: :created, location: @rating }
      else
        format.html { render :new }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @rating.update(rating_params)
        format.js {render 'create'}
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rating
      @rating = Rating.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rating_params
      params.require(:rating).permit(:value)
    end
end
