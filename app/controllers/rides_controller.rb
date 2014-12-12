class RidesController < ApplicationController

  before_action :authenticate_user, :only => [:show]

  def create
    @user = User.find(params[:ride][:user_id])
    @ride = Ride.create
    @ride.update_associated_landings(ride_params)
    redirect_to user_path(@user)
  end

  def show
    @ride = Ride.find(params[:id])
  end

  private

  def ride_params
    params.require(:ride).permit(:requester_landing_id, :acceptor_landing_id, :user_id, :destination_id)
  end

  def authenticate_user
    redirect_to root_url unless Ride.find(params[:id]).users.include?(current_user)
  end
end
