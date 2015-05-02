class PagesController < ApplicationController
  def main
    redirect_to login_path unless logged_in?
  end

  def help
  end

  def about
  end

  def contact
  end
end
