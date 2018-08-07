require 'rack-flash'
class UsersController < ApplicationController

  use Rack::Flash

  get '/signup' do
    erb :'users/create_user'
  end

  post '/signup' do
  end

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    user = User.find_By(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/itineraries'
    else
      redirect '/login'
  end
end
