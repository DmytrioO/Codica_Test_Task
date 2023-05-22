class UserController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
  end

  def create
    @user = current_user
    @user.upload_image(params[:image]) if params[:image]
    redirect_to user_index_path
  end

  def update
    @user = current_user
    @user.update(user_params)
    redirect_to user_index_path
  end

  private

  def user_params
    params.require(:user).permit(:phone, :first_name, :last_name, :second_name, :birthday, :password)
  end
end
