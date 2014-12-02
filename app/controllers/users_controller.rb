class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_user_landing_path(@user)
    else
      render "new"
    end
  end

  def show
    @user = User.find(params[:id])
    @destination = Destination.new
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :phone_number)
  end
end
