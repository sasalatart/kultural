class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(mail: params[:session][:mail].downcase)

    if user && user.authenticate(params[:session][:password])
      log_in(user)
      flash[:notice] = "Bienvenido, #{user.name}"
      redirect_to user
    else
      flash.now[:alert] = 'Error: datos incorrectos'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
