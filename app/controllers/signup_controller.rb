class SignupController < ApplicationController
  layout 'form_layout'
  require 'payjp'
  Payjp.api_key = Rails.application.secrets.PAYJP_PRYVATE_KEY
  
  #不正アクセス対策
  before_action :redirect_to_index_from_sms,only: :sms_authentication
  before_action :redirect_to_index_from_credit,only: :creditcard
  before_action :redirect_to_index_from_sms_confirmation,only: :sms_confirmation
  before_action :redirect_to_index_from_address, only: :address
  before_action :redirect_to_root_user_signed_in

  def index
  end

  def registration
    @user = User.new
    @profile = Profile.new
  end

  #1→2ページへのバリデーション判定
  def first_validation
    session[:nickname] = user_params[:nickname]
    session[:email] = user_params[:email]
    session[:password] = user_params[:password]
    session[:password_confirmation] = user_params[:password_confirmation]
    session[:birthyear] = profile_params[:birthyear]
    session[:birthmonth] = profile_params[:birthmonth]
    session[:birthday] = profile_params[:birthday]
    session[:family_name] = profile_params[:family_name]
    session[:personal_name] = profile_params[:personal_name]
    session[:family_name_kana] = profile_params[:family_name_kana]
    session[:personal_name_kana] = profile_params[:personal_name_kana]
    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation]
    )
    @profile = Profile.new(
      user: @user,
      birthyear: session[:birthyear],
      birthmonth: session[:birthmonth],
      birthday: session[:birthday],
      family_name: session[:family_name],
      personal_name: session[:personal_name],
      family_name_kana: session[:family_name_kana],
      personal_name_kana: session[:personal_name_kana],
      post_family_name: "仮登録",
      post_personal_name: "仮登録",
      post_family_name_kana: "カリ",
      post_personal_name_kana: "トウロク",
      prefecture: '沖縄',
      city: '那覇市',
      address: 'テスト',
      postal_code: '888-8888'
    )
    #バリデーションエラーを事前に取得させる
    check_user_valid = @user.valid?
    check_profile_valid = @profile.valid?
    unless verify_recaptcha(model: @profile) && check_user_valid && check_profile_valid
      render 'signup/registration' 
    else
      session[:through_first_valid] = "through_first_valid"
      redirect_to sms_authentication_signup_index_path
    end
  end

  def sms_authentication
    @profile = Profile.new
  end

  # sms送信アクション(SMS送信可能な番号が限られているためコメントアウト)
  # 使用する場合は、環境変数に自身のtwillioAPIを設定してコメントアウトを外して動作させてください。
  def sms_post
    @profile = Profile.new
    # render sms_authentication_signup_index_path unless  profile_params[:tel].present?
    # phone_number = profile_params[:tel].sub(/\A./,'+81')
    # sms_number = rand(10000..99999)
    # session[:sms_number] = sms_number
    # client = Twilio::REST::Client.new(Rails.application.secrets.TWILLIO_SID,Rails.application.secrets.TWILLIO_TOKEN)
    # begin 
    #   client.api.account.messages.create(from: Rails.application.secrets.TWILLIO_NUMBER, to: phone_number,body: sms_number)
    # rescue
    #   render "signup/sms_authentication"
    #   return false
    # end
    session[:through_send_number] = "through_send_number"
    redirect_to sms_confirmation_signup_index_path
  end
  
  def sms_confirmation
    @profile = Profile.new
  end

  # smsの確認(SMS送信可能な番号が限られているためコメントアウト)
  # 使用する場合は、環境変数に自身のtwillioAPIを設定してコメントアウトを外して動作させてください。
  def sms_check
    @profile = Profile.new
    # sms_number = profile_params[:tel]
    # if sms_number.to_i == session[:sms_number]
      session[:sms_through] = "sms_through"
      redirect_to address_signup_index_path
    # else
    #  render "signup/sms_confirmation"
    # end
  end

  def address
    @profile = Profile.new
  end

  def creditcard
  end

  def done
    unless session[:id]
      redirect_to signup_index_path 
      return false
    end
    sign_in User.find(session[:id])
  end
  
  #3→4ページ目のバリデーション判定
  def second_validation
    session[:prefecture] = profile_params[:prefecture]
    session[:city] = profile_params[:city]
    session[:address] = profile_params[:address]
    session[:postal_code] = profile_params[:postal_code]
    session[:tel] = profile_params[:tel]
    session[:building] = profile_params[:building]
    session[:post_family_name] = profile_params[:post_family_name]
    session[:post_personal_name] = profile_params[:post_personal_name]
    session[:post_family_name_kana] = profile_params[:post_family_name_kana]
    session[:post_personal_name_kana] = profile_params[:post_personal_name_kana]
    @user = User.new(
      nickname: session[:nickname],
      email: session[:email],
      password: session[:password],
      password_confirmation: session[:password_confirmation]
    )
    @profile = Profile.new(
      user: @user,
      birthyear: session[:birthyear],
      birthmonth: session[:birthmonth],
      birthday: session[:birthday],
      family_name: session[:family_name],
      personal_name: session[:personal_name],
      family_name_kana: session[:family_name_kana],
      personal_name_kana: session[:personal_name_kana],
      post_family_name: session[:post_family_name],
      post_personal_name: session[:post_personal_name],
      post_family_name_kana: session[:post_family_name_kana],
      post_personal_name_kana: session[:post_personal_name_kana],
      prefecture: session[:prefecture],
      city: session[:city],
      address: session[:address],
      postal_code: session[:postal_code]
    )
    unless @profile.valid? 
      render 'signup/address' 
    else
      session[:through_second_valid] = "through_second_valid"
      redirect_to creditcard_signup_index_path
    end
  end

  #ユーザー情報の一括create
  def create
    @user = User.new(nickname: session[:nickname],email: session[:email],password: session[:password],password_confirmation: session[:password_confirmation])
    unless @user.save
      reset_session
      redirect_to signup_index_path
      return
    end
    @profile = Profile.create(
      user: @user,
      birthyear: session[:birthyear],
      birthmonth: session[:birthmonth],
      birthday: session[:birthday],
      family_name: session[:family_name],
      personal_name: session[:personal_name],
      family_name_kana: session[:family_name_kana],
      personal_name_kana: session[:personal_name_kana],
      post_family_name: session[:post_family_name],
      post_personal_name: session[:post_personal_name],
      post_family_name_kana: session[:post_family_name_kana],
      post_personal_name_kana: session[:post_personal_name_kana],
      prefecture: session[:prefecture],
      city: session[:city],
      address: session[:address],
      postal_code: session[:postal_code],
      tel: session[:tel],
      building: session[:building]
    )
    customer = Payjp::Customer.create(card: params[:payjp_token])
    @creditcard = Creditcard.new(user: @user,customer_id: customer.id,card_id: customer.default_card)
    if @creditcard.save
      reset_session
      session[:id] = @user.id
      redirect_to done_signup_index_path
      return 
    else
      reset_session
      redirect_to signup_index_path
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:nickname,:email,:password,:password_confirmation)
  end

  def profile_params
    params.require(:profile).permit(:birthyear,:birthmonth,:birthday,:family_name,:personal_name,:family_name_kana,:personal_name_kana,:postal_code,:prefecture,:city,:address,:building,:tel,:post_family_name,:post_personal_name,:post_family_name_kana,:post_personal_name_kana)
  end
  
  def redirect_to_index_from_sms
    redirect_to signup_index_path unless session[:through_first_valid].present? && session[:through_first_valid] == "through_first_valid"
  end

  def redirect_to_index_from_credit
    redirect_to signup_index_path unless session[:through_second_valid].present? && session[:through_second_valid] == "through_second_valid"
  end

  def redirect_to_index_from_sms_confirmation
    redirect_to signup_index_path unless session[:through_send_number].present? && session[:through_send_number] == "through_send_number"
  end

  def redirect_to_index_from_address
    redirect_to signup_index_path unless session[:sms_through].present? && session[:sms_through] == "sms_through"
  end
end