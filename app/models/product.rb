class Product < ActiveRecord::Base
  has_many :product_pictures

  accepts_nested_attributes_for :product_pictures, :allow_destroy => true
end
