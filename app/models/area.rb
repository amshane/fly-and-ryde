class Area < ActiveRecord::Base

  has_many :destinations
  has_many :users, through: :destinations

end
