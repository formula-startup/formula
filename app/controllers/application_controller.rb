class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  protect_from_forgery with: :exception
  before_action :set_form
  
  private

  def set_form
    @form = SearchForm.new
  end

  def production?
    Rails.env.production?
  end
  
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end
  
  def redirect_to_root_user_signed_in
    redirect_to root_path if user_signed_in?
  end

  def redirect_to_login_form_unless_signed_in
    redirect_to new_signin_path unless user_signed_in?
  end

end
