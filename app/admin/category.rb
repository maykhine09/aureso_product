ActiveAdmin.register Category do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :name
filter :name

  index do
    selectable_column
    id_column
    column :name
    actions
  end

  show do |i|
    attributes_table do
      row :id
      row :name
    end
  end

  form do |f|
    f.inputs "New Product" do
      f.input :name
    end
    f.actions
  end

end
