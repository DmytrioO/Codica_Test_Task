class UserPasswordController < ApplicationController
  require 'bcrypt'

  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    bcrypt_password = BCrypt::Password.new(@user.encrypted_password)
    if bcrypt_password == params[:current_password]
      @user.update(password: params[:new_password])
    else
      error = 'The current password is incorrect!'
    end

    redirect_to user_index_path(error: error)
  end
end
