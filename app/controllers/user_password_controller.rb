class UserPasswordController < ApplicationController
  require 'bcrypt'

  before_action :authenticate_user!

  def edit; end

  def update
    bcrypt_password = BCrypt::Password.new(current_user.encrypted_password)

    if bcrypt_password == params[:current_password]
      current_user.update(password: params[:new_password])
    else
      error = 'The current password is incorrect!'
    end

    redirect_to user_index_path(error: error)
  end
end
