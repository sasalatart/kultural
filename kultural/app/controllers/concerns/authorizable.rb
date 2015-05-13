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

  def correct_user
    unless current_user.id == params[:id]
      flash[:alert] = 'Este contenido no está disponible para usted'
      redirect_to root_path
    end
  end
end