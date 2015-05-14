class MembershipsController < ApplicationController

  before_action :logged_in_user

  def create
    @group = Group.find(params[:group_id])
    current_user.join_group(@group)
    respond_to do |format|
      format.html {redirect_to @group}
      format.js
    end
  end

  def destroy
    @group = Membership.find_by(id: params[:id]).group
    current_user.leave_group(@group)
    respond_to do |format|
      format.html {redirect_to @group}
      format.js
    end
  end



end
