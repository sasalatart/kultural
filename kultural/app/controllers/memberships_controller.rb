class MembershipsController < ApplicationController

  before_action :logged_in_user
  before_action :has_permission

  def create
    @group = Group.find(params[:group_id])
    current_user.join_group(@group)
    respond_to do |format|
      format.html {redirect_to @group}
      format.js
    end
  end

  def update
    @membership = Membership.find_by(id: params[:id])
    @membership.is_admin = params[:is_admin]

  end

  def destroy
    @group = Membership.find_by(id: params[:id]).group
    current_user.leave_group(@group)
    respond_to do |format|
      format.html {redirect_to @group}
      format.js
    end
  end

  private

  def set_membership
    @membership = Membership.find(params[:id])
  end

  def has_permission
    unless current_user == @membership.user || current_user.is_group_admin?(@membership.group)
      flash[:alert] = 'You are not allowed to perform this action'
      redirect_to root_path
    end
  end

end
