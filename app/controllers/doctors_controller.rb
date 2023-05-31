class DoctorsController < ApplicationController
  def index
    @doctors = User.doctor
  end

  def show
    @doctor = User.find_by(id: params[:id])
  end
end
