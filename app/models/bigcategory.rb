class Bigcategory < ApplicationRecord
  belongs_to :category_index, optional:true
  belongs_to :product,        optional:true
  has_many   :smallcategories  
end
