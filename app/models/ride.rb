class Ride < ActiveRecord::Base
  has_many :landings
  has_many :users, through: :landings
  has_many :destinations, through: :landings

  def update_associated_landings(ride_params)
    [:requester_landing_id, :accepter_landing_id].each do |key|
      landing = Landing.find(ride_params[key])
      landing.update(:status => "pending", :ride_id => self.id)
    end
  end

end
