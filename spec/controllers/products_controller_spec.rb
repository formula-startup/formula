require "rails_helper"

describe ProductsController do
  describe 'GET #new' do
    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET #show' do
    it "renders the :show template" do
      category = create(:category_index)
      product  = create(:product)
      get :show, params:{id:product.id}
    end

    it "assigns the requested product to @product" do
      category = create(:category_index)
      product  = create(:product)
      get :show, params: {id:product.id}
      expect(assigns(:product)).to eq product
    end
  end

  describe 'POST #create' do
    it 'redirect to error page if error' do
      category = create(:category_index)
      user     = create(:user)
      sign_in(user)
      post :create, params:{ product:{title:"test product", text:"test text", category_index_id: 1, fresh_status:"新品、未使用", deliver_way:"ゆうパック", deliver_person:"送料込み(出品者負担)", from_area:"三重県", deliver_leadtime:"3-4日で発送", price:"3000"}, product_image: attributes_for(:product_image, {image:["test.jpeg", "test2.jpeg"]})}
      expect(response).to redirect_to("http://test.host/")
    end
  end

  describe 'POST #create' do
    it 'redirect to root page if created' do
      category = create(:category_index)
      user     = create(:user)
      sign_in(user)
      post :create, params:{ product:{title:"test product", text:"test text", category_index_id: 1, fresh_status:"新品、未使用", deliver_way:"ゆうパック", deliver_person:"送料込み(出品者負担)", from_area:"三重県", deliver_leadtime:"3-4日で発送", price:"3000"}, product_image: {image:["test.jpeg", "test2.jpeg"]}}
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'GET #edit' do
    it "assigns the requested product to @product" do
      category = create(:category_index)
      product  = create(:product)
      get :edit, params: {id:product.id}
      expect(assigns(:product)).to eq product
    end

    it "renders the :edit template" do
      category = create(:category_index)
      product  = create(:product)
      get :edit, params:{id:product.id}
      expect(response).to render_template :edit
    end
  end

  describe 'PATCH #update' do
    it 'redirect to error page if error' do
      category = create(:category_index)
      user     = create(:user)
      product  = create(:product)
      sign_in(user)
      patch :update, params:{ id: product.id ,product:{user_id: user.id, title:"test product", text:"test text", category_index_id: 1, fresh_status:"新品、未使用", deliver_way:"ゆうパック", deliver_person:"送料込み(出品者負担)", from_area:"三重県", deliver_leadtime:"3-4日で発送", price:"3000"}, product_image: attributes_for(:product_image, {image:["test.jpeg", "test2.jpeg"]})}
      expect(response).to render_template :edit
    end

    it 'redirect to root page if updated' do
      category = create(:category_index)
      user     = create(:user)
      product  = create(:product, user: user)
      sign_in(user)
      patch :update, params:{ id: product.id ,product:{user_id: user.id, title:"test product", text:"test text", category_index_id: 1, fresh_status:"新品、未使用", deliver_way:"ゆうパック", deliver_person:"送料込み(出品者負担)", from_area:"三重県", deliver_leadtime:"3-4日で発送", price:"3000"}}

  describe 'DELETE #destroy' do
    it 'redirect to root page if deleted' do
      category = create(:category_index)
      user = create(:user)
      sign_in(user)
      product = create(:product)
      delete :destroy, params: {id:product.id}
      expect(response).to redirect_to(root_path)
    end
  end
end
