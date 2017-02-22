class ProductPicture < ActiveRecord::Base
  belongs_to :product
  mount_uploader :url, ImageUploader

  def self.check_and_create(product,picture_params)
  	pictures = []
  	pictures = eval(picture_params)
  	pictures.each do |p|
  		if p.present?
  			data_url = p
	      data_type = data_url.split(",")

	        # Check which decode method to use
	      if ( data_type[0] == 'data:image/jpeg;base64' )
	        png = Base64.decode64(data_url['data:image/jpeg;base64,'.length .. -1])
	      elsif ( data_type[0] == 'data:image/png;base64' )
	        png = Base64.decode64(data_url['data:image/png;base64,'.length .. -1])
	      else
	        return render json: { message: "image type not supported" }, status: 400
	      end
	      tmp_file_name = Time.now.to_s << 'report-image.png'

	      File.open('public/' + tmp_file_name, 'wb') { |f| f.write(png) }

	      image = MiniMagick::Image.open('public/'+ tmp_file_name)

	      @path = "public/"

	      @file_name = 'thumb'

	      image.write(@path + "#{@file_name}.jpg")

	      @data = File.open("#{@path}#{@file_name}.jpg", "rb")

	      # create the ReportImage obj because '@reports.create' knew only the string
	     	@productpicture = ProductPicture.new(:product_id => product.id, :url => @data)

	      # delete the temp files
	      if ( @data )
	      File.delete(Rails.root + "#{@path}#{@file_name}.jpg")
	      File.delete(Rails.root + "#{@path}#{tmp_file_name}") if tmp_file_name.present?
	      end
  		end
  		unless @productpicture.save!
	      return render text: { message: @user.errors} ,status: 404
	    end
  	end
  end
end
