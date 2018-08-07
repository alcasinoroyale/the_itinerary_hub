require 'rack-flash'
class UsersController < ApplicationController

  use Rack::Flash

  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      redirect '/'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == ""
      redirect '/signup'
      else
        @user = User.new(username: params[:username], email: params[:email], password: params[:password])
        @user.save
        session[:user_id] = user.id
        redirect to "/users/#{@user.slug}"
    end
  end

  get '/login' do
    if !logged_in?
      erb :'/users/login'
    else
      redirect to '/'
    end
  end

  post '/login' do
    @user = User.find_By(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      @user = current_user
      flash[:message] = "Welcome Back to the Itinerary Hub, #{@user.username}!"
      redirect '/users/show'
    else
      flash[:message] = "The username or password that you entered is incorrect."
      redirect '/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect '/login'
    else
      redirect to '/'
  end
end
