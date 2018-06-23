require "rack-flash"

class AppointmentsController < ApplicationController

use Rack::Flash

  get '/appointments' do
    if logged_in?
      @appointments = Appointment.all
      erb :'/appointments/appointments'
    else
      flash[:message] = "Please login to view appointments"
      redirect '/login'
    end
  end

  get '/appointments/new' do
    if logged_in?
      erb :'/appointments/create_appointment'
    else
      redirect "/users/login"
    end
  end

  post '/appointments' do
    if !params.empty?
      @appointment = Appointment.create(params)
      @user.id = current_user.id
      @appointment.user_id = @user.id
      current_user.appointments << @appointment
      current_user.save
      redirect '/appointments'
    else
      redirect "/appointments/new"
    end
  end
end
