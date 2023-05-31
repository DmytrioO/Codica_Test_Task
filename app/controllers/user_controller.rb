class UserController < ApplicationController
  before_action :authenticate_user!

  def index; end

  def update
    current_user.update(user_params)
    current_user.upload_image(params[:image]) if params[:image]
    redirect_to user_index_path
  end

  def edit; end

  private

  def user_params
    params.permit(:phone, :first_name, :last_name, :second_name, :birthday, :password)
  end
end
