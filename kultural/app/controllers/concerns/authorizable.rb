# Ideas obtenidas del libro 'Ruby on Rails Tutorial (3rd ed.)' de Michael Hartl

module Authorizable
  extend ActiveSupport::Concern

  include Sessionable

  def logged_in_user
    unless logged_in?
      flash[:alert] = 'Debe haber iniciado sesión para acceder aquí'
      redirect_to login_path
    end
  end

  def owner_of_event
    unless current_user == Event.find(params[:id]).owner
      not_available_forwarding
    end
  end

  def owner_of_place
    unless current_user == Place.find(params[:id]).owner
      not_available_forwarding
    end
  end

  def correct_user
    unless current_user == User.find(params[:id])
      not_available_forwarding
    end
  end

  def not_available_forwarding
    flash[:alert] = 'Este contenido no está disponible para usted'
    redirect_to root_path
  end
end