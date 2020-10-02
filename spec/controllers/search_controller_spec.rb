require 'rails_helper'

RSpec.describe SearchController, type: :controller do

  describe 'GET #index' do
    it "renders the :index template" do
      get :index, params: {search_form: {keyword: ""}}
      expect(response).to render_template :index
    end

    it "match the products" do
      keyword = "a"
      user = create(:user)
      200.times{create(:product,user: user,category_index_id: "")}
      products = Product.where(["title LIKE(?) OR text LIKE(?) OR fresh_status LIKE(?) OR deliver_way LIKE(?) OR from_area LIKE(?)","%#{keyword}%","%#{keyword}%","%#{keyword}%","%#{keyword}%","%#{keyword}%"])
      get :index, params: {search_form: {keyword: keyword}}
      expect(assigns(products)).to eq(@products)
    end

  end
end
