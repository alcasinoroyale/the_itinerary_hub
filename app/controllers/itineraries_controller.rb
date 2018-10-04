require 'rack-flash'
class ItinerariesController < ApplicationController
  get '/itineraries' do #reading all of the itineraries
    redirect_if_not_logged_in
    erb :'/itineraries/index'
  end

  get '/itineraries/new' do #create an Itinerary
      redirect_if_not_logged_in
      erb :'itineraries/new'
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
    redirect_if_not_logged_in
      if @itinerary = Itinerary.find_by(id: params[:id])
        erb :'/itineraries/show'
      else
        redirect to '/itineraries'
    end
  end

  get '/itineraries/:id/edit' do #Edit an Itinerary
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

  delete '/itineraries/:id/delete' do #Delete an Itinerary
    if logged_in?
      @itinerary = Itinerary.find_by(id: params[:id])
      if @itinerary && @itinerary.user == current_user
        @itinerary.destroy
        flash[:message] = "Your itinerary has been successfully deleted."
        redirect to '/itineraries'
      else
        flash[:message] = "You cannot delete other users itineraries."
        redirect to '/itineraries/'
    end
  end
end
end
