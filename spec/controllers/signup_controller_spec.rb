require 'rails_helper'

RSpec.describe SignupController, type: :controller do
  include SpecTestHelper
  describe 'GET #registration' do
    it "renders the :registration template" do
      get :registration
      expect(response).to render_template :registration
    end
  end

  describe 'POST #registration' do
    it "renders the :registration template" do
      post :registration
      expect(response).to render_template :registration
    end
  end

  describe 'GET #sms_authentication' do
    it "renders the :sms_authentication template without session" do
      get :sms_authentication
      expect(response).to redirect_to(signup_index_path)
    end

    it "renders the :sms_authentication template with session" do
      session = {through_first_valid: "through_first_valid"}
      add_session(session)
      get :sms_authentication
      expect(response).to render_template :sms_authentication
    end
  end

  describe 'POST #sms_authentication' do
    it "renders the :sms_authentication template without session" do
      post :sms_authentication
      expect(response).to redirect_to(signup_index_path)
    end
  end

  describe 'GET #sms_confirmation' do
    it "renders the :sms_confirmation template without session" do
      get :sms_confirmation
      expect(response).to redirect_to(signup_index_path)
    end

    it "renders the :sms_confirmation  template with session" do
      session = {through_send_number: "through_send_number"}
      add_session(session)
      get :sms_confirmation
      expect(response).to render_template :sms_confirmation
    end
  end

  describe 'GET #address' do
    it "renders the :address template without session" do
      get :address
      expect(response).to redirect_to(signup_index_path)
    end

    it "renders the :address template with session" do
      session = {sms_through: "sms_through"}
      add_session(session)
      get :address
      expect(response).to render_template :address
    end
  end

  describe 'GET #creditcard' do
    it "renders the :creditcard template without session" do
      get :creditcard
      expect(response).to redirect_to(signup_index_path)
    end

    it "renders the :creditcard template with session" do
      session = {through_second_valid: "through_second_valid"}
      add_session(session)
      get :creditcard
      expect(response).to render_template :creditcard
    end
  end

  describe 'GET #done' do
    it "renders the :done template without session" do
      get :done
      expect(response).to redirect_to(signup_index_path)
    end

    it "renders the :done template with session" do
      user = create(:user)
      session = {id: user.id}
      add_session(session)
      get :done
      expect(response).to render_template :done
    end
  end

end
