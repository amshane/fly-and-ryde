class Landing < ActiveRecord::Base
  belongs_to :user
  belongs_to :airport
  belongs_to :destination
  belongs_to :ride

  validates :airline, :flight_num, :arrival_date, :arrival_time, :destination_id, :airport_id, presence: true


  def matches
    matches_array = []
    landings = Landing.where(:status => "available")
    landings.each do |l|
      if self.airport_id == l.airport_id && self.arrival_date == l.arrival_date && self.user_id != l.user_id && time_difference(l) && self.destination.borough == l.destination.borough
        matches_array << l
      end
    end
    matches_array
  end

  def time_difference(landing)
    diff = (self.arrival_time - landing.arrival_time).abs
    hours = (diff/60.0)/60.0
    hours <= 3
  end

  def get_wait_time(match)
    time_difference = (self.arrival_time - match.arrival_time).abs
    minutes = (time_difference/60.0).to_i
    hours = (minutes/60).to_i
    remaining_minutes = (minutes % 60).to_i
    if minutes < 60
      "#{minutes} minutes"
    else
      "#{hours} hours and #{remaining_minutes} minutes"
    end
  end

  def get_pending_match
    Landing.where(:ride_id => self.ride_id, :status => "requested").where.not(:id => self.id)[0]
  end

  def get_acceptor
    Landing.where(:status => "pending", :ride_id => self.ride_id).where.not(:user_id => self.user_id)[0].user
  end

  def get_confirmed_match
    Landing.where(:ride_id => self.ride_id, :status => "complete").where.not(:id => self.id)[0]
  end

end
