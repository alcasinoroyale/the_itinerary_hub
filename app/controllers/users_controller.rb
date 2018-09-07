require 'rack-flash'
class UsersController < ApplicationController

  use Rack::Flash

  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      redirect '/itineraries'
    end
  end

  post '/signup' do
    active_user = User.find_by(email: params[:email])
    if params[:username] == "" || params[:password] == ""
      redirect to '/users/create_user'
      else
        @user = User.new(username: params[:username], email: params[:email], password: params[:password])
        @user.save
        session[:user_id] = @user.id
        flash[:message] = "User created successfully."
        redirect to "/users/#{@user.slug}"
    end
  end

  get '/login' do
    if !logged_in?
      erb :'/users/login'
    else
      redirect to "/users/#{@user.slug}"
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:message] = "Welcome Back to the Itinerary Hub, #{@user.username}!"
      redirect to '/users/show'
    else
      flash[:message] = "The username or password that you entered is incorrect."
      redirect to '/users/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
    end
      redirect to '/'
  end

  get '/users/:slug' do
    if logged_in?
      @user = User.find_by_slug(params[:slug])
      erb :'/users/show'
    else
      redirect '/'
    end
  end
end
