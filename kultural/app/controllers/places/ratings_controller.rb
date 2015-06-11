class Places::RatingsController < RatingsController
  before_action :set_rateable

  private

    def set_rateable
      @rateable = Place.find(params[:place_id])
    end
end
