class ValidatorController < ApplicationController

before_action :current_user

  def mail
    mail = params[:mail].downcase
    user = User.find_by_mail(mail)
    boolean_response !user || (user == current_user)
  end

  private

  def boolean_response(truth)
    respond_to do |format|
      format.json {render json: {valid: truth} }
    end
  end
end
