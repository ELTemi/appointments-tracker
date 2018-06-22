users_list = {
    "Temi Alan" => {
      :email => "temialan@abc.com",
      :username => "temialan17",
      :password_digest => "nalat"
    }
  }

users_list.each do |name, user_hash|
  p = User.new
  p.name = name
  user_hash.each do |attribute, value|
      p[attribute] = value
  end
  p.save
end

appointments_list = {
    "Doctor's Appointment" => {
    :date => 2018-11-22,
    :location => "Waterloo, Canada",
    :details => "Appointment to see doctor about my eyes",
    :status => false
    }
  }

appointments_list.each do |title, appointment_hash|
  p = Appointment.new
  p.title = title
  p.save
end
