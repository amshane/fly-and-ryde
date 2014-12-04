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

  def edit
    @destination = Destination.find(params[:id])
  end

  def update
    @destination = Destination.find(params[:id])
    if @destination.update(destination_params) 
      redirect_to user_path(@destination.user)
    else
      render "edit"
    end
  end

  def destroy
    @destination = Destination.find(params[:id])
    @user = @destination.user
    @destination.destroy
    redirect_to user_path(@user)
  end

  private

    def destination_params
      params.require(:destination).permit(:name, :address, :lat, :long, :user_id)
    end

end
