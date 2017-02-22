class Api::ProductController < ApplicationController
	skip_before_filter :verify_authenticity_token

	def create
		@product = Product.where(:name => params[:name]).first
		return render json: { message: "Product with the name already exist!"} if @product.present?

		@product = Product.new( :name => params[:name],
														:SKU_ID => params[:SKU_ID],
														:expire_date => params[:expire_date],
														:price => params[:price],
														:description => params[:description])
		if @product.save!
			if params[:categories].present?
      	ProductCategory.check_and_create(@product,params[:categories])
	    end
	    if params[:pictures].present?
	    	ProductPicture.check_and_create(@product,params[:pictures])
    	end
    	return render json: @product
		else
			return render json: { message: @product.errors }, status: 400
		end
	end
end
