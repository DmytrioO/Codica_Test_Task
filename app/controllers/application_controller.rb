class ApplicationController < ActionController::Base
  helper_method %i[make_date make_time]
  def make_date
    array = []
    date = if DateTime.now < '18:00'.to_datetime
             Date.today
           else
             Date.tomorrow
           end
    20.times do |number|
      array << date + number
    end
    array
  end

  def make_time(date, doctor)
    end_time = DateTime.parse("#{date} 18:00")
    array = []

    if date.to_date == Date.today
      current_time = (Time.at((Time.now.to_f / 15.minutes).round * 15.minutes)).to_datetime
      current_time += 15.minutes if current_time <= DateTime.now
    else
      current_time = DateTime.parse("#{date} 08:00")
    end

    while current_time <= end_time
      if doctor.appointments_as_doctor.find_by(date_time: "#{date} #{current_time.strftime('%H:%M')}").nil?
        array << current_time
      end
      current_time += 15.minutes
    end

    array
  end

  def authenticate_admin!
    redirect_to root_path unless current_user&.admin?
  end

  def current_admin_user
    current_user if current_user&.admin?
  end
end
