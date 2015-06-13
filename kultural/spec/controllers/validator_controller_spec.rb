require 'rails_helper'

RSpec.describe ValidatorController, type: :controller do

  describe "GET #new_mail" do
    it "returns http success" do
      get :new_mail
      expect(response).to have_http_status(:success)
    end
  end

end
