class User < ActiveRecord::Base
  has_secure_password
  has_many :itineraries

  validates :username, :email, presence: true
  validates :username, :email, uniqueness: true

  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods
end
