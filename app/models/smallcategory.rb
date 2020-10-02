class Smallcategory < ApplicationRecord
  belongs_to :bigcategory, optional:true
  belongs_to :product,     optional:true
  has_many   :sizes
  has_many   :smallcategories_has_sizes
end
