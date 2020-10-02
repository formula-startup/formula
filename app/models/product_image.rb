class ProductImage < ApplicationRecord
  mount_uploader :image, ImagesUploader

  validates  :image,     presence: true
  
  belongs_to :product,   optional: true, dependent: :destroy
end
