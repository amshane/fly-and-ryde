class Ride < ActiveRecord::Base
  has_many :landings
  has_many :users, through: :landings
  has_many :destinations, through: :landings

  def update_associated_landings(ride_params)
    requester = Landing.find(ride_params[:requester_landing_id])
    requester.update(:status => "requested", :ride_id => self.id)

    accepter = Landing.find(ride_params[:accepter_landing_id])
    accepter.update(:status => "pending", :ride_id => self.id)
  end

end
