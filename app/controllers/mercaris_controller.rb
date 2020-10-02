class MercarisController < ApplicationController
  before_action :set_categories
  def index
    @products        = Product.order('created_at DESC').limit(10)
  end

  private

  def set_categories
    @categories      = CategoryIndex.all
    @bigcategories   = Bigcategory.all
    @smallcategories = Smallcategory.all
  end
end
