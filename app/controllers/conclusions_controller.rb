class ConclusionsController < ApplicationController
  before_action :authenticate_user!

  def new; end

  def create
    @appointment = Appointment.find(params[:appointment_id])

    if can? :create, Conclusion
      if @appointment.conclusion.nil?
        Conclusion.create(recommendations: params[:recommendations], appointment: @appointment)
        @appointment.update(status: 'closed')
      end

      redirect_to @appointment
    end
  end
end
