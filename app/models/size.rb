class Size < ApplicationRecord
  belongs_to :product, optional:true
  has_many   :smallcategories
  has_many   :smallcategories_has_sizes
end
