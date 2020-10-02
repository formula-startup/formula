class SigninController < ApplicationController
  layout 'form_layout'
  before_action :redirect_to_root_user_signed_in

  def new
    @signin = Signin.new
  end

  def index
    redirect_to new_signin_path
  end

  def create
    @signin = Signin.new(email: signin_params[:email], password: signin_params[:password])
    #バリデーションエラーを事前に取得
    check_valid = @signin.valid?
    unless verify_recaptcha(@signin) && check_valid
      render "signin/new"
    else
      @user = User.find_by_email(@signin.email)
      if @user.present? && @user.valid_password?(@signin.password)
        sign_in @user unless user_signed_in?
        redirect_to root_path
      else
        session[:signin_error] = "メールアドレスまたはパスワードが違います"
        render "signin/new"
      end
    end
  end

  private

  def signin_params
    params.require(:signin).permit(:email, :password)
  end

end
