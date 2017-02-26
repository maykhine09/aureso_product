class Api::V1::ProductsController < ApplicationController
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
    if params["product"][:product_pictures_attributes].present?
      params["product"][:product_pictures_attributes].each do |pics|
        pictures = ProductPicture.new
        pictures.url = pics["url"]
        @product.product_pictures << pictures
      end
    end

    tag_name = []
    if params[:tags][:name].present?
      tag_names = params[:tags][:name].split(",").map(&:strip)
      tag_names.each do |tag|
        @tag = Tag.find_or_create_by(name: tag)
        tag_name.push(@tag.name)
      end
      @product.tag_list.add(tag_name) if tag_name.count != 0
    end

    if @product.save!
      if params["categories"][:name].present?
        ProductCategory.check_and_create(@product,params["categories"][:name])
      end

      if params["vars"].present?
        Var.check_and_create(@product,params[:vars],params[:models])
      end
      flash.now[:success] = 'Product Created!'
      redirect_to "http://aureso-product.herokuapp.com/api/v1/products/new"
      # redirect_to "http://localhost:3000/products/new"
    else
      return render json: { message: @product.errors }, status: 400
    end
  end

  private
  def product_params
    params.require(:product).permit(:name, :SKU_ID, :price, :description, :expire_date, :tag_list)
  end
end
