class LandingsController < ApplicationController

  def new
    @landing = Landing.new
    @user = User.find(params[:user_id])
    @destination = Destination.new
  end

  def show
    @user = User.find(params[:user_id])
    @landing = Landing.find(params[:id])
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

  private

  def landing_params
    params.require(:landing).permit(:airport_id, :user_id, :destination_id, :ride_id, :arrival_time, :complete, :airline, :flight_num, :arrival_date)
  end

end
