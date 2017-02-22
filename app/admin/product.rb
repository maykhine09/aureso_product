ActiveAdmin.register Product do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :name, :SKU_ID, :price, :description, :expire_date,
:product_pictures_attributes => [:id, :product_id, :url,:_create,:_update,:_destroy],
:product_categories_attributes => [:id, :product_id, :category_id,:_create,:_update,:_destroy]

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
    column 'Picuture' do |product| 
        image_tag(product.product_pictures.first.url.url, :size => '50x50') unless product.product_pictures.first.nil?
      end
    actions
  end

  show do |i|
    attributes_table do
      row :id
      row :name
      row :SKU_ID
      row :price
      row :categories do
        if i.categories.present?
          i.categories.map { |c| c.name }.join(", ")
        end
      end
    end
    panel "Product Pictures" do
      table_for i.product_pictures do
        column :url do |a|
          if a.url.present?
            image_tag a.url.url,:size => '200x200'
          end
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
      f.input :categories, collection: Category.order("name ASC")
    end
    f.inputs "Add Product Pictures" do
      f.has_many :product_pictures, :allow_destroy => true do |p|
        p.input :url, :as => :file, :label => "Image",:hint => image_tag(p.object.url.url, size: "100x100")
      end
    end
    f.actions
  end

end
