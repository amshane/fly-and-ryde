class Landing < ActiveRecord::Base
  belongs_to :user
  belongs_to :airport
  belongs_to :destination
  belongs_to :ride


  def matches
    matches_array = []
    landings = Landing.where(:status => "available")
    landings.each do |l|
      if self.airport_id == l.airport_id && self.arrival_date == l.arrival_date && self.id != l.user_id
        matches_array << l
      end
    end
    matches_array
  end

  def get_pending_match
    Landing.where(:ride_id => self.ride_id).where.not(:id => self.id)[0] 
  end

end
