ActiveAdmin.register Model do

menu parent: 'Vars', priority: 2

permit_params :var_id, :name

filter :name

  index do
    selectable_column
    id_column
    column :var_id
    column :name
    actions
  end

  show do |i|
    attributes_table do
      row :id
      row :var_id
      row :name
    end
  end

  form do |f|
    f.inputs "New Product" do
      f.input :var
      f.input :name
    end
    f.actions
  end
end
