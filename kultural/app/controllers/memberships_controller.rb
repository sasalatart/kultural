class MembershipsController < ApplicationController

  before_action :logged_in_user
  before_action :set_membership, only: [:update, :destroy]
  before_action :has_permission, only: [:update, :destroy]

  def create
    @group = Group.find(params[:group_id])
    current_user.join_group(@group)
    respond_to do |format|
      format.html {redirect_to @group}
      format.js
    end
  end

  def update
    @membership.is_admin = !@membership.is_admin
    @membership.save
    respond_to do |format|
      format.html {redirect_to members_group_path id: @membership.group.id}
      format.js
    end

  end

  def destroy
    @group = @membership.group
    @membership.user.leave_group(@group)
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
