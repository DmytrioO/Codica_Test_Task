# frozen_string_literal: true

class User::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  def create
    super do |resource|
      resource.first_name = resource.first_name.capitalize
      resource.last_name = resource.last_name.capitalize
      resource.second_name = resource.second_name.capitalize if resource.second_name.present?
      resource.photo = 'https://codica-test-task-bucket.s3.eu-central-1.amazonaws.com/no_image.png'
      resource.save
    end
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[phone first_name last_name second_name birthday password])
  end
end
