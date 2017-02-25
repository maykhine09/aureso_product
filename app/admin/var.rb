ActiveAdmin.register Var do

menu parent: 'Vars', priority: 1
permit_params :color,
:models_attributes => [:name]

filter :color

index do
    selectable_column
    id_column
    column :color
    column 'Models' do |model|
      var.modles.count
    end
    actions
  end

  show do |i|
    attributes_table do
      row :color
      row :modles do
        if i.modles.present?
          i.modles.map { |t| t.name }.join(", ")
        end
      end
    end
  end

  form do |f|
    f.inputs "New Var" do
      f.input :color, as: :string
      f.input :models, collection: Model.order("name ASC")
    end
    f.actions
  end


end
