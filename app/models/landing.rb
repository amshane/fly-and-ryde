class Landing < ActiveRecord::Base
  belongs_to :user
  belongs_to :airport
  belongs_to :destination
  belongs_to :ride

end
