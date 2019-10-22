class User < ActiveRecord::Base
  has_secure_password
  has_many :itineraries

  validates :username, :email, presence: true
  validates :username, :email, uniqueness: true

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
