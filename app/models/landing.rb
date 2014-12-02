class Landing < ActiveRecord::Base
  belongs_to :user
  belongs_to :airport
  belongs_to :destination
  belongs_to :ride


  def matches
    matches_array = []
    landings = Landing.where.not(user_id: self.id)
    landings.each do |l|
      if self.airport_id == l.airport_id && self.arrival_date == l.arrival_date
        matches_array << l
      end
    end
    matches_array
  end

end
