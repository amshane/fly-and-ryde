class Destination < ActiveRecord::Base
  has_many :landings
  belongs_to :user
  validates :name, :address, presence: true
  validates :name, :uniqueness => {:scope => :user_id}
  before_save :downcase_name, :get_neighborhood_and_borough

  # geocoded_by :address, {:latitude  => :lat, :longitude => :long} # ActiveRecord
  # after_validation :geocode          # auto-fetch coordinates

  def get_neighborhood_and_borough
    latlng = Geocoder.coordinates(self.address + "NY")
    if latlng != nil
      self.lat = latlng[0]
      self.long = latlng[1]
      result = Geocoder.search(latlng).first

      self.neighborhood = result.address_components_of_type(:neighborhood).first["long_name"]
      self.borough = result.address_components_of_type(:sublocality).first["long_name"]
    else
      false
    end
  end
  
  private
    def downcase_name
      self.name = self.name.downcase
    end

end
