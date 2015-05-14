module PlacesHelper
  def owner_of_place?
    current_user == Place.find(params[:id]).owner
  end
end
