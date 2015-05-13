module EventsHelper
  def owner_of_event?
    if logged_in? && current_user == Event.find(params[:id]).owner
      return true
    else
      return false
    end
  end
end
