ActiveAdmin.register Tag do

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
