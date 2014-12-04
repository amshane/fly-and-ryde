class DestinationsController < ApplicationController

  def create
    @user = User.find(params[:destination][:user_id])
    @destination = Destination.create(destination_params)
    @destination.get_neighborhood_and_borough
    redirect_to user_path(@user)
  end

  private

    def destination_params
      params.require(:destination).permit(:name, :address, :lat, :long, :user_id)
    end

end
