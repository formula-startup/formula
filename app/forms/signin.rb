class Signin
  include ActiveModel::Model

  attr_accessor :email, :password 
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :password, presence: true, length: {minimum: 7, maximum: 128}
  
end