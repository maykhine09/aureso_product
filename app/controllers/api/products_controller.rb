class Api::ProductsController < ApplicationController
	skip_before_filter :verify_authenticity_token

	def new
		@product = Produt.new(product_params)
		
	end

	def create
		@product = Product.where(:name => params[:name]).first
		return render json: { message: "Product with the name already exist!"} if @product.present?

		@product = Product.new(product_params)
		tag_name = []
		if params[:tags].present?
			if params[:tags].kind_of?(Array)
        tag_names = params[:tags]
      else
        tag_names = params[:tags].gsub(/"|\[|\]/, "").split(",")
      end
			tag_names.each do |tag|
				@tag = Tag.find_or_create_by(name: tag)
				tag_name.push(@tag.name)

			end
			@product.tag_list.add(tag_name) if tag_name.count != 0
		end

		if @product.save!
			if params[:categories].present?
      	ProductCategory.check_and_create(@product,params[:categories])
	    end
	    if params[:pictures].present?
	    	ProductPicture.check_and_create(@product,params[:pictures])
    	end
    	if params[:vars].present?
    		Var.check_and_create(@product,params[:vars])
    	end
		else
			return render json: { message: @product.errors }, status: 400
		end
	end

	private
	def product_params
		params.permit(:name, :SKU_ID, :price, :description, :expire_date, :tag_list)
	end
end


