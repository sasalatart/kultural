# Ideas obtenidas del libro 'Ruby on Rails Tutorial (3rd ed.)' de Michael Hartl

module Sessionable
  extend ActiveSupport::Concern

  def log_in(user)
    session[:user_id] = user.id
  end

  # Prevents hitting the db multiple times.
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # Returns true if we have a logged_in user, and false if not.
  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end