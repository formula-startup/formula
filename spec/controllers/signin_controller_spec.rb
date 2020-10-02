require 'rails_helper'

RSpec.describe SigninController, type: :controller do
  
  describe 'GET #new' do
    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #index' do
    it "renders the :index template" do
      get :index
      expect(response).to redirect_to(new_signin_path)
    end
  end

  describe 'POST #create' do
    it "match the :create user" do
      user = create(:user)
      post :create, params: {signin: {email: user.email,password: user.password}}
      expect(assigns(:user)).to eq user 
    end

    it "renders the :create with wrong params" do
      user = create(:user)
      post :create, params: {signin: {email: "dummy", password: "dummy"}}
      expect(response).to render_template :new
    end
  end

end
