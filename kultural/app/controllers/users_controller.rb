class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :change_password, :update,
                                  :destroy, :following, :followers,
                                  :ajax_avatar]

  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @title = 'Users'
    @users = User.paginate(page: params[:page], per_page: 8)
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def change_password
  end

  def create
    @user = User.new(user_params)

    if @user.save
      background do
        UserMailer.signup_confirmation(@user).deliver
      end

      log_in @user
      flash[:notice] = "Welcome tu kultur.al, #{@user.name}"
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    respond_to do |format|
      password_changed = !(current_user.authenticate(user_params[:password]))

      if @user.update(user_params)
        background do
          if password_changed
            UserMailer.password_change(@user).deliver
          else
            UserMailer.account_edit(@user).deliver
          end
        end

        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        if password_changed
          format.html { render :change_password }
        else
          format.html { render :edit }
        end
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    background do
      UserMailer.account_delete(@user).deliver
    end

    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def following
    @title = 'Following to'
    @users = @user.following
    render 'index'
  end

  def followers
    @title = 'Followers of'
    @users = @user.followers
    render 'index'
  end

  def ajax_avatar
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation,
                                   :mail, :phone, :birthday, :male, :avatar)
    end
end
