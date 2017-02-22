class Product < ActiveRecord::Base
  has_many :product_pictures
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories

  accepts_nested_attributes_for :product_pictures, :allow_destroy => true
	accepts_nested_attributes_for :product_categories, :allow_destroy => true

	validates_presence_of :name, :SKU_ID
end
