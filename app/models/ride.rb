class Ride < ActiveRecord::Base
  has_many :landings
  has_many :users, through: :landings
  has_many :destinations, through: :landings

end
