class ItinerariesController < ApplicationController
  get '/itineraries' do #reading all of the itineraries
      if logged_in?
        @user = current_user
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
end
