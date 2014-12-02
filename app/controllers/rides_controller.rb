class RidesController < ApplicationController

  def create
    @user = User.find(params[:user_id])
    @ride = Ride.create
    @ride.update_associated_landings(ride_params)
    redirect_to user_path(@user)
  end

  private

  def ride_params
    params.require(:ride).permit(:requester_landing_id, :accepter_landing_id)
  end
end
