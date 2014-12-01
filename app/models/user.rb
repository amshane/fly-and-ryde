class User < ActiveRecord::Base
  has_many :landings
  has_many :rides, through: :landings
  has_many :airports, through: :landings
  has_many :destinations

end
