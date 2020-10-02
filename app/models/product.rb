class Product < ApplicationRecord
  # バリデーション
  validates :title,               length:    {maximum: 40},         presence: true
  validates :text,                length:    {maximum: 1000},       presence: true
  validates :category_index_id,   exclusion: {in: %w(---) }
  validates :fresh_status ,       exclusion: {in: %w(---) }
  validates :deliver_way,         exclusion: {in: %w(---)}
  validates :deliver_person,      exclusion: {in: %w(---)}
  validates :from_area,           exclusion: {in: %w(都道府県)}
  validates :deliver_leadtime,    exclusion: {in: %w(---)}
  validates :price,               numericality: [greater_than: 300, less_than: 10000000 ]

  # アソシエーション
  belongs_to :user,              optional:true
  belongs_to :brand,             optional:true
  has_many :product_images,      dependent: :delete_all
  accepts_nested_attributes_for :product_images
  has_one :trade
  
  # カテゴリ関係
  has_one :category_index
  has_one :bigcategory
  has_one :smallcategory
  has_one :size
end
