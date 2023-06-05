class ApplicationController < ActionController::Base
  helper_method %i[make_date make_time]
  def make_date
    array = []
    date = if DateTime.now < DateTime.parse("#{Date.today} 18:00 +0300")
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
    end_time = DateTime.parse("#{date} 18:00 +0300")
    array = []

    if date.to_date == Date.today
      current_time = Time.at((Time.now.to_f / 15.minutes).round * 15.minutes).to_datetime
      current_time += 15.minutes if current_time <= DateTime.now
    else
      current_time = DateTime.parse("#{date} 08:00 +0300")
    end

    while current_time <= end_time
      if doctor.appointments_as_doctor.where('date_time = ? AND (status = ? OR status = ?)', DateTime
        .parse(current_time.strftime('%d.%m.%Y %H:%M +0000')), 0, 1).empty?
        array << current_time
      end
      current_time += 15.minutes
    end

    array
  end
end
