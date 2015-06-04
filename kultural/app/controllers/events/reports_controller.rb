class Events::ReportsController < ReportsController
  before_action :set_reportable

  private

    def set_reportable
      @reportable = Event.find(params[:event_id])
    end
end
