class Airport < ActiveRecord::Base
  has_many :landings
  has_many :users, through: :landings
  has_many :rides, through: :landings

end
