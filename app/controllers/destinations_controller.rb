class DestinationsController < ApplicationController

  def create
    @user = User.find(params[:destination][:user_id])
    @destination = Destination.new(destination_params)
    if @destination.save
      redirect_to user_path(@user)
    else
      redirect_to user_path(@user), :notice => "error creating destination"
    end
  end

  private

    def destination_params
      params.require(:destination).permit(:name, :address, :lat, :long, :user_id)
    end

end
