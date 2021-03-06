class UsersController < ApplicationController

  before_action :authenticate_user, :only => [:show, :edit]

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
      flash.now[:error] = "You must enter your phone number to continue!"
      render "edit" 
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :phone_number)
  end

  def authenticate_user 
    redirect_to root_url unless current_user.id.to_s == params[:id] 
  end
end
