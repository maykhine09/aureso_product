class Category < ActiveRecord::Base
	has_many :product_categories
end
