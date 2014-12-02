class LandingsController < ApplicationController

  def new
    @landing = Landing.new
    @user = User.find(params[:user_id])
    @destination = Destination.new
  end

  def show
  end

  def create
  end

end
