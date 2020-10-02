class UsersController < ApplicationController
  before_action :redirect_to_login_form_unless_signed_in
  before_action :set_categories
  def index
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def show
    @user = current_user
    @categories      = CategoryIndex.all
    @bigcategories   = Bigcategory.all
    @smallcategories = Smallcategory.all
  end

  def delete
  end

  def credit_register
  end

  def logout
  end

  private

  def set_categories
    @categories      = CategoryIndex.all
    @bigcategories   = Bigcategory.all
    @smallcategories = Smallcategory.all
  end

end
