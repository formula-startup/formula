require 'rails_helper'

RSpec.describe PurchaseController, type: :controller do
  describe 'GET #new' do
    it "renders the :new template" do
      category = create(:category_index)
      user = create(:user)
      profile = create(:profile, user: user)
      sign_in(user)
      product = create(:product, user: user)
      get :new,params: {product_id: product.id}
      expect(response).to render_template :new
    end
  end

  describe 'GET #index' do
    it "renders the :index template" do
      category = create(:category_index)
      user = create(:user)
      profile = create(:profile, user: user)
      sign_in(user)
      product = create(:product, user: user)
      get :index,params: {product_id: product.id}
      expect(response).to render_template :index
    end
  end

  describe 'POST #create' do
    it "match the :create user" do
      category = create(:category_index)
      user = create(:user)
      profile = create(:profile, user: user)
      sign_in(user)
      product = create(:product, user: user)
      post :create,params: {product_id: product.id}
      expect(response).to render_template :new
    end
  end

end
