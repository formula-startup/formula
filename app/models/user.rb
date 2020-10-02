class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise   :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_one  :profile,       dependent: :destroy
  has_one  :creditcard,    dependent: :destroy
  has_many :products,      dependent: :destroy
  has_many :buyer_trades,  class_name: "Trade", foreign_key: "buyer_id",  dependent: :destroy
  has_many :seller_trades, class_name: "Trade", foreign_key: "seller_id", dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  PASSWORD_VALIDATION = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{7,128}+\z/i
  validates :email,                 presence: true, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
  validates :password,              presence: true, length: {minimum: 7, maximum: 128},    format: { with: PASSWORD_VALIDATION }
  validates :password_confirmation, presence: true, length: {minimum: 7, maximum: 128}
  validates :nickname,              presence: true, length: {maximum: 20}
end
