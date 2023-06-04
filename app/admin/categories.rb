ActiveAdmin.register Category do
  permit_params :name

  index do
    selectable_column
    column :name
    actions
  end

  show do
    attributes_table do
      row :name
    end
  end
end
