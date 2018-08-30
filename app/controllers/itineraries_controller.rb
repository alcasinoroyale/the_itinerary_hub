require 'rack-flash'
class ItinerariesController < ApplicationController
  get '/itineraries' do #reading all of the itineraries
      if logged_in?
        @itineraries = Itinerary.all
        erb :'/itineraries/index'
      else
        redirect to '/login'
    end
  end

  get '/itineraries/new' do #create an Itinerary
      if logged_in?
        erb :'itineraries/new'
      else
        redirect to '/login'
    end
  end

  post '/itineraries' do
    if params[:itinerary] == ""
      erb :'itineraries/new'
    else
      @itinerary = current_user.itineraries.build(params)
      @itinerary.user = current_user
      @itinerary.save
      redirect to "/itineraries/#{@itinerary.id}"
    end
  end

  get '/itineraries/:id' do
    if logged_in?
      if @itinerary = Itinerary.find_by(id: params[:id])
        erb :'/itineraries/show'
      else
        redirect to '/itineraries'
      end
    else
      redirect to '/login'
    end
  end

  get '/itineraries/:id/edit' do
    @itinerary = Itinerary.find_by(id: params[:id])
    if logged_in? && current_user.itineraries.include?(@itinerary)
        erb :'/itineraries/edit'
    else
      flash[:message] = "You only have the ability to edit your itineraries."
      redirect to '/itineraries'
    end
  end

  patch '/itineraries/:id' do
    @itinerary = current_user.itineraries.find_by(id: params[:id])
      if params[:itinerary] != ""
        @itinerary.update(destinations: params[:destinations], travel_guide: params[:travel_guide], schedule: params[:schedule])
        redirect to "/itineraries/#{@itinerary.id}"
      elsif
        redirect to "/itineraries/#{@itinerary.id}/edit"
      else
        flash[:message] = "You do not have access to other users itineraries."
        redirect to '/itineraries'
    end
  end

  delete '/itineraries/:id/delete' do
    if logged_in?
      @itinerary = Itinerary.find_by(id: params[:id])
      if @itinerary && @itinerary.user == current_user
        @itinerary.destroy
        redirect to '/itineraries/'
      else
        flash[:message] = "You cannot delete other users itineraries"
        redirect to '/itineraries/'
    end
  end
end
end
