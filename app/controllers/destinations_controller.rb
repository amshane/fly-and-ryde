class DestinationsController < ApplicationController

  def create
    @user = User.find(params[:destination][:user_id])
    @destination = Destination.create(destination_params)
    redirect_to user_path(@user)
  end

  private

    def destination_params
      params.require(:destination).permit(:name, :address, :lat, :long, :user_id, :area_id, :neighborhood, :borough)
    end

end
