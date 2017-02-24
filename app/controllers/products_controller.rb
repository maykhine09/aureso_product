class ProductsController < ApplicationController
	skip_before_filter :verify_authenticity_token

	def new
		@product = Product.new()
		respond_to do |format|
      format.html { render :new }
    end
	end

	def create
		@product = Product.where(:name => params["product"][:name]).first
		return render json: { message: "Product with the name already exist!"} if @product.present?

		@product = Product.new(product_params)
		# tag_name = []
		# if params[:tags].present?
		# 	if params[:tags].kind_of?(Array)
  #       tag_names = params[:tags]
  #     else
  #       tag_names = params[:tags].gsub(/"|\[|\]/, "").split(",")
  #     end
		# 	tag_names.each do |tag|
		# 		@tag = Tag.find_or_create_by(name: tag)
		# 		tag_name.push(@tag.name)

		# 	end
		# 	@product.tag_list.add(tag_name) if tag_name.count != 0
		# end

			# params[:attachment].each do |image|
		 #    img = ProductPicture.new
		 #    img.url = image
		 #    @item.images << img
		 #  end

		if @product.save!
			if params["product"][:categories].present?
      	ProductCategory.check_and_create(@product,params[:categories])
	    end
	    
    	if params["product"][:vars].present?
    		Var.check_and_create(@product,params[:vars])
    	end
    	respond_to do |format|
	    	format.json { render :show, status: :created, location: @program }
	    end
		else
			return render json: { message: @product.errors }, status: 400
		end
	end

	private
	def product_params
		params.require(:product).permit(:name, :SKU_ID, :price, :description, :expire_date, :tag_list, :categories, :vars, product_pictures_attributes: [:url])
	end
end
