class Destination < ActiveRecord::Base
  has_many :landings
  belongs_to :user

end
