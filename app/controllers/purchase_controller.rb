class PurchaseController < ApplicationController
  skip_before_action :verify_authenticity_token
  Payjp.api_key = Rails.application.secrets.PAYJP_PRYVATE_KEY
  layout 'form_layout'
  before_action :redirect_to_login_form_unless_signed_in

  def index
    @product = Product.find(params[:product_id])
    @post_address = current_user.profile.prefecture + current_user.profile.city + current_user.profile.address
    @post_name = current_user.profile.post_family_name + current_user.profile.post_personal_name
    @card = current_user.creditcard
    if @card.blank?
      @card = "カード情報がありません"
    else
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @customer_card = customer.cards.retrieve(@card.card_id)
    end
  end

  def new
    @product = Product.find(params[:product_id])
    @post_address = current_user.profile.prefecture + current_user.profile.city + current_user.profile.address
    @post_name = current_user.profile.post_family_name + current_user.profile.post_personal_name
    @card = current_user.creditcard
    if @card.blank?
      @card = "カード情報がありません"
    else
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @customer_card = customer.cards.retrieve(@card.card_id)
    end
  end

  def create
    @product = Product.find(params[:product_id])
    @trade = Trade.new(buyer_id: current_user.id, seller_id: @product.user.id, product: @product)
    if current_user.id != @product.user.id && current_user.creditcard.present?
      card = current_user.creditcard
      Payjp::Charge.create(
        amount: @product.price,
        customer: card.customer_id,
        currency: 'jpy'
      )
      @trade.save
      @product.update(sell_status: "交渉中")
      redirect_to product_purchase_index_path(@product)
    else
      render "purchase/new"
    end
  end
  
end
