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
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      if params[:username] == "" || params[:password] == ""
        redirect to '/users/create_user'
      elsif @user.save
        session[:user_id] = @user.id
        flash[:message] = "User created successfully."
        redirect to "/users/#{@user.slug}"
      else
        flash[:message] = "This user info already exists"
        redirect to 'users/create_user'
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
      redirect to "/users/#{@user.slug}"
    else
      flash[:message] = "The username or password that you entered is incorrect."
      redirect to '/users/login'
    end
  end

  get '/users' do
    @users = User.all
    @most_traveled_user = User.most_traveled
    redirect_if_not_logged_in
    erb :'/users/index'
  end

  get '/logout' do
    if logged_in?
      session.destroy
    end
      redirect to '/'
  end

  get '/users/:slug' do
    if logged_in?
      @users = User.all
      @user = User.find_by_slug(params[:slug])
      erb :'/users/show'
    else
      redirect '/'
    end
  end


  get '/users/:slug/edit' do
    if logged_in? && current_user
      @user = User.find_by_slug(params[:slug])
      erb :'/users/edit'
    else
      redirect to '/users/show'
    end
  end


  patch '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    @user.update(username: params[:username])
    redirect to '/users'
  end
end
