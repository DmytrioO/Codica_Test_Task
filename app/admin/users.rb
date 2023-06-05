ActiveAdmin.register User, as: 'Doctor' do
  scope :doctors, default: true do
    User.where(role: :doctor)
  end

  permit_params :first_name, :last_name, :second_name, :phone, :category_id, :birthday

  index do
    selectable_column
    column :full_name, &:full_name
    column :category
    column :phone
    column :birthday
    column :created_at
    actions
  end

  show do
    if resource.patient?
      controller.redirect_to '/admin/doctors', alert: 'Access denied.'
    else
      attributes_table do
        row :first_name
        row :last_name
        row :second_name
        row :phone
        row :birthday
      end
    end
  end

  form title: 'User' do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :second_name
      f.input :phone
      f.input :category
      f.input :birthday, as: :date_select, start_year: 1900, end_year: DateTime.now.years_ago(18).year
    end

    actions
  end

  controller do
    after_create do |user|
      user.update(role: :doctor, password: '123#QWEqwe',
                  photo: 'https://codica-test-task-bucket.s3.eu-central-1.amazonaws.com/no_image.png')
    end
  end
end
