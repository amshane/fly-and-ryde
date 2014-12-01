class Ride < ActiveRecord::Base
  has_many :landings, limit: 2
  has_many :users, through: :landings
  has_many :destinations, through: :landings

end
