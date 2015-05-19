class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(mail: params[:session][:mail].downcase)

    if user && user.authenticate(params[:session][:password])
      log_in(user)
      flash[:notice] = "Welcome, #{user.name}"
      redirect_to user
    else
      flash.now[:alert] = 'Error: credentials do not match'
      render 'new'
    end
  end

  def destroy
    log_out
    flash[:notice] = 'You have logged out'
    redirect_to root_path
  end
end
