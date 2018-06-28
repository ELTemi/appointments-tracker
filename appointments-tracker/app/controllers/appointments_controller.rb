require "rack-flash"

class AppointmentsController < ApplicationController

use Rack::Flash

  get '/appointments' do
    if logged_in?
      valid_login
      @appointments = current_user.appointments
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
      flash[:message] = "Please login to create an appointment"
      redirect "/users/login"
    end
  end

  post '/appointments' do
    if logged_in?
      valid_login
      @appointment = @user.appointments.build([title: params[:title], date: params[:date], location: params[:location], details: params[:details], status: params[:status]])
      @user.save
      if @user.save
        redirect to "/appointments/#{@appointment.first.id}"
      else
        redirect to "/appointments/new"
      end
    else
      flash[:message] = "Please login to view appointments"
      redirect to "/login"
    end
  end

  get '/appointments/:id' do
    if logged_in?
      valid_login
      @appointment = Appointment.find_by_id(params[:id])
      erb :'appointments/show_appointment'
    else
      flash[:message] = "Please login to view appointments"
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
        flash[:message] = "You can only edit your appointments"
        redirect to '/appointments'
      end
    else
      flash[:message] = "Please login to edit appointments"
      redirect to "/login"
    end
  end

  patch '/appointments/:id' do
    if logged_in?
      if params[:title] == "" || params[:date] == "" || params[:location] == ""
        redirect to "/appointments/#{params[:id]}/edit"
      else
        @appointment = Appointment.find_by_id(params[:id])
        if @appointment && @appointment.user_id == current_user.id
          if @appointment.update(title: params[:title], date: params[:date], location: params[:location], details: params[:details], status: params[:status])
            redirect to "/appointments/#{@appointment.id}"
          else
            flash[:message] = "No valid changes have been made to appointment"
            redirect to "/appointments/#{@appointment.id}/edit"
          end
        else
          flash[:message] = "You can only edit your appointments"
          redirect to '/appointments'
        end
      end
      flash[:message] = "Please login to make changes to appointments"
      redirect to '/login'
    end
  end

  delete '/appointments/:id/delete' do
    if logged_in?
      @appointment = Appointment.find_by_id(params[:id])
      if @appointment && @appointment.user_id == current_user.id
        @appointment.delete
        flash[:message] = "Appointment deleted"
      end
      redirect to '/appointments'
    else
      flash[:message] = "Please login to delete appointments"
      redirect to '/login'
    end
  end

end
