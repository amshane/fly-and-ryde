class LandingsController < ApplicationController

  before_action :authenticate_user, :only => [:show]

  def new
    @landing = Landing.new
    @user = User.find(params[:user_id])
    @destination = Destination.new
  end

  def show
    @user = User.find(params[:user_id])
    @landing = Landing.find(params[:id])
    @ride = Ride.new
  end

  def create
    @user = User.find(params[:user_id])
    @landing = Landing.new(landing_params)
    if @landing.save
      redirect_to user_landing_path(@user, @landing)
    else
      render "new"
    end
  end

  def update
    @landing = Landing.find(params[:id])
    if @landing.update(status_params)
      if @landing.status == "available"
        @landing.get_pending_match.update(:status => "available")
        redirect_to user_landing_path(@landing.user, @landing)
      else
        @landing.get_pending_match.update(:status => "complete")
        redirect_to ride_path(@landing.ride)
      end
    end
  end
  private

  def landing_params
    params.require(:landing).permit(:airport_id, :user_id, :destination_id, :ride_id, :arrival_time, :complete, :airline, :flight_num, :arrival_date, :borough)
  end

  def status_params
    params.require(:landing).permit(:status)
  end

  def authenticate_user
    redirect_to root_url unless Landing.find(params[:id]).user_id == current_user.id.to_s
  end

end
