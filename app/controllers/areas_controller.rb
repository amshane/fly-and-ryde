class AreasController < ApplicationController

  def create
    @user = User.find(params[:area][:user_id])
    @area = Area.create(area_params)
  end

  private

    def area_params
      params.require(:area).permit(:borough, :neighborhood, :user_id)
    end

end