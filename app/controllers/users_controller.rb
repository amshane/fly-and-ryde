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
      redirect_to user_path(@user)
    else
      render "new"
    end
  end

  def show
    @user = User.find(params[:id])
    @destination = Destination.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params) && @user.valid_phone_number(user_params[:phone_number])
      redirect_to user_path(@user)
    else
      render "edit", :notice => "You must enter your phone number to continue!"
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :phone_number)
  end
end
