module PlacesHelper
  def owner_of_place?
    owner = Place.find(params[:id]).owner
    if owner.is_a? User
      current_user == owner
    else
      current_user.groups_where_is_admin.include? owner
    end
  end
end
