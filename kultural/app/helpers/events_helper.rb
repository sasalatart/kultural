module EventsHelper
  def owner_of_event?
    current_user == Event.find(params[:id]).owner
  end
end
