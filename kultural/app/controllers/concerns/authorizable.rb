# Ideas obtenidas del libro 'Ruby on Rails Tutorial (3rd ed.)' de Michael Hartl

module Authorizable
  extend ActiveSupport::Concern

  include Sessionable

  def logged_in_user
    unless logged_in?
      flash[:alert] = 'Error: you must log in to access this'
      redirect_to login_path
    end
  end

  def owner_of_event?
    owner = Event.find(params[:id]).owner
    unless current_user == owner || (owner.is_a?(Group) && current_user.is_group_admin?(owner))
      not_available_forwarding
    end
  end

  def owner_of_place?
    owner = Place.find(params[:id]).owner
    unless current_user == owner || (owner.is_a?(Group) && current_user.is_group_admin?(owner))
      not_available_forwarding
    end
  end

  def correct_user
    unless current_user == User.find(params[:id])
      not_available_forwarding
    end
  end

  def is_group_admin
    unless current_user.is_group_admin? Group.find(params[:id])
      not_available_forwarding
    end
  end

  def not_available_forwarding
    flash[:alert] = 'Error: you are not allowed to perform this action'
    redirect_to root_path
  end
end