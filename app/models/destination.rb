class Destination < ActiveRecord::Base
  has_many :landings
  belongs_to :user
  belongs_to :area

  def manhattan_neighborhoods
    Area.where(borough: "Manhattan")
  end

  def brooklyn_neighborhoods
    Area.where(borough: "Brooklyn")
  end

  def queens_neighborhoods
    Area.where(borough: "Queens")
  end

end
