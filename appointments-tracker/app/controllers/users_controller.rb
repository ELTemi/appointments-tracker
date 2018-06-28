require "rack-flash"

class UsersController < ApplicationController

  use Rack::Flash

  get '/users/:slug' do
    @user = User.find_by_id(params[:slug])
    erb :'/users/account'
  end

  get '/signup' do
    if logged_in?
      redirect "/appointments"
    else
      flash[:message] = "Either username/name/email already exists. Please try again!"
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    @user = User.new(params)
    if @user.save
      session[:id] = @user.id
      redirect :'/appointments'
    else
      redirect :'/signup'
    end
  end

  get '/login' do
    if logged_in?
      flash[:message] = "You are already logged in"
      redirect '/appointments'
    else
      flash[:message] = "Could not find username and/or password!"
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect '/appointments'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      flash[:message] = "You are already logged out"
      redirect '/'
    end
  end


end
