class Destination < ActiveRecord::Base
  has_many :landings
  belongs_to :user

  geocoded_by :address, {:latitude  => :lat, :longitude => :long, :neighborhood => "address.neighborhood"} # ActiveRecord
  after_validation :geocode          # auto-fetch coordinates

  def get_neighborhood_and_borough
    @latlng = Geocoder.coordinates(self.address + "NY")
    result = Geocoder.search(@latlng).first

    neighborhood = result.address_components_of_type(:neighborhood).first["long_name"]
    borough = result.address_components_of_type(:sublocality).first["long_name"]
    self.update(:neighborhood => neighborhood, :borough => borough)
  end



end
