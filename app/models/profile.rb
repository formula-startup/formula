class Profile < ApplicationRecord
  belongs_to :user
  POSTAL_CODE_VALID = /\A\d{3}-\d{4}\z/i
  
  validates :birthyear,               presence: true
  validates :birthmonth,              presence: true
  validates :birthday,                presence: true
  validates :family_name,             presence: true, length: {maximum: 35}
  validates :personal_name,           presence: true, length: {maximum: 35}
  validates :family_name_kana,        presence: true, length: {maximum: 35}
  validates :personal_name_kana,      presence: true, length: {maximum: 35}
  validates :postal_code,             presence: true, length: {maximum: 100}, format: { with: POSTAL_CODE_VALID }
  validates :prefecture,              presence: true, length: {maximum: 100}
  validates :city,                    presence: true, length: {maximum: 50}
  validates :address,                 presence: true, length: {maximum: 100}
  validates :post_family_name,        presence: true, length: {maximum: 35}
  validates :post_personal_name,      presence: true, length: {maximum: 35}
  validates :post_family_name_kana,   presence: true, length: {maximum: 35}
  validates :post_personal_name_kana, presence: true, length: {maximum: 35}
  validates :tel,                                     length: {maximum: 100}
end
