class Places::ReportsController < ReportsController
  before_action :set_reportable

  private

    def set_reportable
      @reportable = Place.find(params[:place_id])
    end
end