class ProductPicture < ActiveRecord::Base
  belongs_to :product
  mount_uploader :url, ImageUploader
end
