ActiveAdmin.register Product do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :name, :SKU_ID, :price, :description, :expire_date,
:product_picutures_attributes => [:id,:url,:_create,:_update,:_destroy]

filter :name
filter :SKU_ID
filter :price
filter :expire_date

index do
    selectable_column
    id_column
    column :name
    column :SKU_ID
    column :price
    actions
  end

  show do |i|
    attributes_table do
      row :id
      row :name
      row :SKU_ID
      row :price
    end
    panel "Product Pictures" do
      table_for a.product_pictures do
        column :url do |i|
          i.url.present? ? image_tag(i.url.url,:size => '200x200') : ''
        end
      end
    end
  end

  form do |f|
    f.inputs "New Product" do
      f.input :name
      f.input :SKU_ID
      f.input :price
      f.input :description
      f.input :expire_date, as: :date_picker
    end
    f.inputs "Add Product Pictures" do
      f.has_many :product_pictures, :allow_destroy => true do |p|
        p.input :url, :as => :file, :label => "Image",:hint => image_tag(p.object.url.url, size: "100x100")
      end
    end
    f.actions
  end

end
