class Itinerary < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :destinations, :travel_guide, :schedule
end
