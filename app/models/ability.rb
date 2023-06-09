class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, User, role: :doctor

    return unless user.present?

    can :read, Appointment, id: user.appointments_as_patient.ids
    can :read, Conclusion, id: Conclusion.joins(:appointment).
      where('appointments.doctor_id = ? OR appointments.patient_id = ?', user.id, user.id)
    can :edit, Appointment, id: Appointment.where('doctor_id = ? OR patient_id = ?', user.id, user.id).ids

    return unless user.doctor?

    can :read, Appointment, id: user.appointments_as_doctor.ids
    can :create, Conclusion
  end
end
