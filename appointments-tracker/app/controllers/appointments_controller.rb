require "rack-flash"

class AppointmentsController < ApplicationController

use Rack::Flash

  get '/appointments' do
    if logged_in?
      @user = current_user
      @appointments = Appointment.all
      erb :'/appointments/appointments'
    else
      flash[:message] = "Please login to view appointments"
      redirect '/login'
    end
  end
end
