require 'HTTParty'

class Ride < ActiveRecord::Base
  has_many :landings
  has_many :users, through: :landings
  has_many :destinations, through: :landings

  def update_associated_landings(ride_params)
    requester = Landing.find(ride_params[:requester_landing_id])
    requester.update(:status => "requested", :ride_id => self.id, :cancelled => false)

    acceptor = Landing.find(ride_params[:acceptor_landing_id])
    acceptor.update(:status => "pending", :ride_id => self.id, :cancelled => false)
  end

  def x_time_estimate
    landing = self.landings.first
    time_response = HTTParty.get("https://api.uber.com/v1/estimates/time?start_latitude=#{landing.airport.latitude}&start_longitude=#{landing.airport.longitude}", :headers => {"Authorization" => "Token EmqmeLypo9yYbX9DQts0ZK6oXbWB3tzGTvZaaoUB"})
    seconds = time_response["times"][0]["estimate"]
    (seconds/60.0).ceil
  end

  def x_price_estimate
    landing = self.landings.first
    price_response = HTTParty.get("https://api.uber.com/v1/estimates/price?start_latitude=#{landing.airport.latitude}&start_longitude=#{landing.airport.longitude}&end_latitude=#{landing.destination.lat}&end_longitude=#{landing.destination.long}", :headers => {"Authorization" => "Token EmqmeLypo9yYbX9DQts0ZK6oXbWB3tzGTvZaaoUB"})
    (price_response["prices"][0]["high_estimate"]).to_i
  end

  def split_estimate
    (x_price_estimate/2)+8
  end

  def surge
    landing = self.landings.first
    price_response = HTTParty.get("https://api.uber.com/v1/estimates/price?start_latitude=#{landing.airport.latitude}&start_longitude=#{landing.airport.longitude}&end_latitude=#{landing.destination.lat}&end_longitude=#{landing.destination.long}", :headers => {"Authorization" => "Token EmqmeLypo9yYbX9DQts0ZK6oXbWB3tzGTvZaaoUB"})
    price_response["prices"][0]["surge_multiplier"]
  end

end
