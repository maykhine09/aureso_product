class ProductCategory < ActiveRecord::Base
	belongs_to :product
	belongs_to :category

	def self.check_and_create(product,categories_params)
    	categories = categories_params.split(",").map(&:strip)
        categories.each do |c|
        	@category = Category.where("lower(name) = ?",c.downcase).first
        	@category = Category.create(:name => c.downcase) if @category.blank?
        	ProductCategory.create(:product_id => product.id,
        											:category_id => @category.id)
        end
    end
end
