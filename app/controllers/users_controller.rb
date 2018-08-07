require 'rack-flash'
class UsersController < ApplicationController

  use Rack::Flash

  get '/signup' do
    if logged_in?
      redirect 'itineraries'
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    user = User.new(params)
    if user.save
      session[:user_id] = user.id
      redirect '/itineraries'
    else
      redirect '/'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/itineraries'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    user = User.find_By(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      @user = current_user
      redirect '/itineraries'
    else
      redirect '/login'
  end
end
