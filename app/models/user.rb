class User < ActiveRecord::Base
  has_many :landings
  has_many :rides, through: :landings
  has_many :airports, through: :landings
  has_many :destinations

  validates :first_name, :last_name, presence: true
  validates_formatting_of :phone_number, :using => :us_phone 

end
