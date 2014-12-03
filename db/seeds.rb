class SeedDatabase
  
  USERS = [["Katie", "Hoffman", "7202327272"], ["Harold", "Cooper", "3038956008"], ["Ayanthika", "Motha", "2125657878"], ["Julia", "Zhang", "7804342323"], ["Sam", "Marcus", "3035556767"], ["Allison", "Shane", "4846669001"]]
  AIRPORTS = [["John F. Kennedy International Airport", "JFK"],["Newark Liberty International Airport", "EWR"],["LaGuardia Airport","LGA"]]
  STREET_NAMES = ["Abbey Rd.","Abbey Rd.","Broadway","Castro St.","Downing St.","Easy St.","Elm St.","Henry St.","High St.", "Lime St.","Ledo Rd.","Madison Ave.","Market Street","National Road","Ocean Dr."]
  AIRLINES = ["Delta", "Spirit","JetBlue","American","Frontier","Virgin","Oceanic","PanAm","Southwest"]

  def initialize
    make_airports
    make_users_and_destinations
    make_landings
    make_common_ride
  end

  def make_users_and_destinations
    USERS.each do |u| 
      u = User.create!(
        :first_name => u[0], 
        :last_name => u[1], 
        :phone_number => u[2]
      )
      make_destinations(u)
    end
  end

  def make_airports
    AIRPORTS.each do |a|
      Airport.create!(
        :name => a[0], 
        :abbreviation => a[1]
      )
    end
  end

  def make_destinations(user)
    ["Home", "Work"].each do |n|
      number = rand(15..1700).to_s
      zip_code = rand(10001..11692).to_s
      Destination.create!(
        :name => n,
        :address => "#{number} #{STREET_NAMES.sample}, New York, NY #{zip_code}",
        :lat =>  rand(40.7100..40.7127),
        :long => rand(74.0040..74.0060),
        :user_id => user.id
      )
    end
  end

  def make_landings
    [3,4,5,6].each do |id|
      user = User.find(id)
      day = rand(0..7)
      hour = rand(1..12)
      arrival_time = Time.now
      arrival_date = Date.new(2014,12,day)
      create_landing(user, arrival_time, arrival_date)
    end
  end

  def create_landing(user, arrival_time, arrival_date)
    Landing.create!(
      :airport_id => Airport.all.sample.id,
      :user_id => user.id,
      :destination_id => user.destinations.sample,
      :arrival_time => arrival_time,
      :arrival_date => arrival_date,
      :airline => AIRLINES.sample,
      :flight_num => rand(10000...90000)
    )
  end

  def make_common_ride
    harold = User.find_by(:first_name => "Harold")
    katie = User.find_by(:first_name => "Katie")
    arrival_time = (Date.today - 1).to_datetime.change(hour:14,min:15)
    ride = Ride.create!(:driver_name => "Elle Woods", :price => 45.67, :uber_confirmation => "42384925885")
    [harold, katie].each do |user|
      make_common_destination(user)
      make_common_landing(user, ride, arrival_time)
    end
  end

  def make_common_destination(user)
    Destination.create!(
      :name => "Locanda Vini & Olii",
      :address => "129 Gates Ave, Brooklyn, NY 11238",
      :lat => 40.685007,
      :long => -73.962943,
      :user_id => user.id
    )
  end

  def make_common_landing(user, ride, arrival_time)
    Landing.create!(
      :airport_id => Airport.find_by(:abbreviation => "JFK").id,
      :user_id => user.id,
      :destination_id => user.destinations.last.id,
      :complete => true,
      :arrival_date => Date.new(2014,12,17),
      :arrival_time => Time.now,
      :ride_id => ride.id,
      :airline => AIRLINES.sample,
      :flight_num => rand(10000...90000),
      :status => "complete"
    )
  end

end

SeedDatabase.new