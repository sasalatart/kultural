class Events::RatingsController < RatingsController
  before_action :set_rateable

  private

    def set_rateable
      @rateable = Event.find(params[:event_id])
    end
end
