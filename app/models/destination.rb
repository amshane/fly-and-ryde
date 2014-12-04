class Destination < ActiveRecord::Base
  has_many :landings
  belongs_to :user
  validates :name, presence: true 
  validate :validate_unique_user_destination
  before_save :downcase_name

  geocoded_by :address, {:latitude  => :lat, :longitude => :long} # ActiveRecord
  after_validation :geocode          # auto-fetch coordinates

  def get_neighborhood_and_borough
    @latlng = Geocoder.coordinates(self.address + "NY")
    result = Geocoder.search(@latlng).first

    neighborhood = result.address_components_of_type(:neighborhood).first["long_name"]
    borough = result.address_components_of_type(:sublocality).first["long_name"]
    self.update(:neighborhood => neighborhood, :borough => borough)
  end

private

  def validate_unique_user_destination
    found_destination =  Destination.where(:user_id => self.user_id, :name => self.name.downcase)
    # binding.pry
    if found_destination.length > 0
      errors.add(:name, "Must have unique name")
    end
  end

  def downcase_name
    self.name = self.name.downcase
  end

end
