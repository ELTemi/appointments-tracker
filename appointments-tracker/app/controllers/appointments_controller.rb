require "rack-flash"

class AppointmentsController < ApplicationController

use Rack::Flash

  get '/appointments' do
    if logged_in?
      valid_login
      @appointments = Appointment.all
      erb :'/appointments/appointments'
    else
      flash[:message] = "Please login to view appointments"
      redirect '/login'
    end
  end

  get '/appointments/new' do
    if logged_in?
      valid_login
      erb :'/appointments/create_appointment'
    else
      redirect "/users/login"
    end


  end

  post '/appointments' do
    @appointment = Appointment.new(params)
    if logged_in?
      @appointment = Appointment.create(title: params[:title], date: params[:date], location: params[:location], details: params[:details], status: params[:status])
      valid_login
      @appointment.user_id = @user.id
      current_user.appointments << @appointment
      current_user.save
      if @appointment.save
        redirect to "/appointments/#{@appointment.id}"
      else
        redirect to "/appointments/new"
      end
    else
      redirect to "/login"
    end
  end

  get '/appointments/:id' do
    if logged_in?
      valid_login
      @appointment = Appointment.find_by_id(params[:id])
      erb :'appointments/show_appointment'
    else
      redirect to "/login"
    end
  end

  get '/appointments/:id/edit' do
    if logged_in?
      valid_login
      @appointment = Appointment.find_by_id(params[:id])
      if @appointment && @appointment.user == current_user
        erb :'/appointments/edit_appointment'
      else
        redirect to '/appointments'
      end
    else
      redirect to "/login"
    end
  end

  patch '/appointments/:id' do
    if logged_in?
      if params[:title] == "" || params[:date] == "" || params[:location] == "" || params[:details] == ""
        redirect to "/appointments/#{@params.id}/edit"
      else
        @appointment = Appointment.find_by_id(params[:id])
        if @appointment && @appointment.user_id == current_user.id
          if @appointment.update(title: params[:title], date: params[:date], location: params[:location], details: params[:details], status: params[:status])
            redirect to "/appointments/#{@appointment.id}"
          else
            redirect to "/appointments/#{@appointment.id}/edit"
          end
        else
          redirect to '/appointments'
        end
      end
      redirect to '/login'
    end
  end

  patch '/appointments/:id/delete' do
    if logged_in?
      @appointment = Appointment.find_by_id(params[:id])
      if @appointment && @appointment.user_id == current_user.id
        @appointment.delete
      end
      redirect to '/appointments'
    else
      redirect to '/login'
    end
  end

end
