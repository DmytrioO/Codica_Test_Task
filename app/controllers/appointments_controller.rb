class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_doctor, only: %i[new create]

  def index
    @appointments = if params[:role] == 'doctor' && current_user.doctor?
                      current_user.appointments_as_doctor
                    else
                      current_user.appointments_as_patient
                    end
    @appointments = @appointments.where(status: params[:status]) if params[:status]
  end

  def show
    @appointment = Appointment.find_by(id: params[:id])
  end

  def new
    @step = params[:step]
    @url = @step == 'submit' ? appointment_create_path : appointment_new_path
  end

  def create
    if params[:doctor_id].to_i == current_user.id
      return @error = "You can't make appointment where patient and doctor are the same person!"
    end

    if @doctor.appointments_as_doctor.where('status = ? OR status = ?', 0, 1).count >= 10
      return @error = "Sorry, but you can't make appointment to this doctor, because he/her have maximum
appointments for now!"
    end

    date_time = DateTime.parse("#{params[:date]} #{params[:time].to_datetime.strftime('%H:%M')}")

    @appointment = Appointment.create(date_time:, doctor_id: params[:doctor_id], patient: current_user)

    unless @appointment.save
      @appointment = nil
      @error = 'Something went wrong! Try one more time!'
    end
  end

  def update
    @appointment = Appointment.find(params[:id])

    if can? :edit, @appointment
      @appointment.update(status: params[:status])
      redirect_to @appointment
    end
  end

  private

  def set_doctor
    @doctor = User.find(params[:doctor_id])
  end
end
