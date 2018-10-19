class User < ActiveRecord::Base
  has_secure_password
  has_many :itineraries

  validates :username, :email, presence: true
  validates :username, :email, uniqueness: true

# add instance method called trip_count that returns the number of itineraries that a user has and then where you're display a username's name, add trip count after
# add class method called most_traveled, return user.trip_count, display on home page

  def self.most_traveled
    self.all.max_by do |user|
      user.trip_count
    end
  end

  def trip_count
    self.itineraries.count
  end

  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods
end
