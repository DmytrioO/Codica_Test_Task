ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation

  index do
    selectable_column
    id_column
    column :phone
    column :created_at
    actions
  end

  filter :phone
  filter :created_at

  form do |f|
    f.inputs do
      f.input :phone
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
