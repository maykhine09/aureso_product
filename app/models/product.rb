class Product < ActiveRecord::Base
  has_many :product_pictures
  has_many :product_categories, dependent: :destroy
  has_many :categories, through: :product_categories
  has_many :vars, dependent: :destroy
  has_many :models, through: :vars

  accepts_nested_attributes_for :product_pictures, :allow_destroy => true
	accepts_nested_attributes_for :product_categories, :allow_destroy => true

	validates_presence_of :name, :SKU_ID

  acts_as_taggable_on :tags

  before_save :change_price

  def change_price
    if self.price != nil
      self.price = self.price * 100
    end
  end
end
