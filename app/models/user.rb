class User < ActiveRecord::Base
  has_many :landings
  has_many :rides, through: :landings
  has_many :airports, through: :landings
  has_many :destinations
  has_many :areas, through: :destinations

  # validates :first_name, :last_name, presence: true
  # validates_formatting_of :phone_number, :using => :us_phone

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.first_name = auth["info"]["first_name"]
      user.last_name = auth["info"]["last_name"]
    end
  end

  def pending_landings
    Landing.where(:status => "pending", :user_id => self.id)
  end

  def confirmed_landings
    Landing.where(:status => "complete", :user_id => self.id)
  end

  def available_landings
    Landing.where(:status => "available", :user_id => self.id)
  end

  def requested_landings
    Landing.where(:status => "requested", :user_id => self.id)
  end

  def valid_phone_number(phone_number)
    regex = /(?:\+?|\b)[0-9]{10}\b/
    r = regex.match(phone_number)
    r != nil
  end

end
