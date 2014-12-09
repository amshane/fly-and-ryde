class DestinationsController < ApplicationController

  def create
    @user = User.find(params[:destination][:user_id])
    @destination = Destination.new(destination_params)
    if @destination.save && @destination.get_neighborhood_and_borough
      redirect_to user_path(@user)
    else
      flash[:error] = "Destination must have unique name and valid address!"
      redirect_to user_path(@user)
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
      flash.now[:error] = "Destination must have unique name and valid address!"
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
