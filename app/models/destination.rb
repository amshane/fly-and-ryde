class Destination < ActiveRecord::Base
  has_many :landings
  belongs_to :user

  geocoded_by :address, :latitude  => :lat, :longitude => :long # ActiveRecord
  after_validation :geocode          # auto-fetch coordinates


end
