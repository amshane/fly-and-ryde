class SeedDatabase
  
  USERS = [["Katie", "Hoffman", "7202327272"], ["Harold", "Cooper", "3038956008"], ["Ayanthika", "Motha", "2125657878"], ["Julia", "Zhang", "7804342323"], ["Sam", "Marcus", "3035556767"], ["Allison", "Shane", "4846669001"]]
  AIRPORTS = [
    ["John F. Kennedy International Airport", "JFK", 40.6413111, -73.77813909999999],
    ["Newark Liberty International Airport", "EWR", 40.6895314, -74.1744624],
    ["LaGuardia Airport","LGA", 40.7769271, -73.8739659]]
  STREET_NAMES = ["Abbey Rd.","Abbey Rd.","Broadway","Castro St.","Downing St.","Easy St.","Elm St.","Henry St.","High St.", "Lime St.","Ledo Rd.","Madison Ave.","Market Street","National Road","Ocean Dr."]
  AIRLINES = ["Delta", "Spirit","JetBlue","American","Frontier","Virgin","Oceanic","PanAm","Southwest"]
  BOROUGHS = ["Manhattan","Brooklyn","Queens"]
  ADDRESSES = ["1577 2nd Ave New York, NY 10028","2041 Broadway New York, NY 10023","596 9th Ave New York, NY 10036","161 7th Ave Brooklyn, NY 11215","117 Front St Brooklyn, NY 11201","7 W 32nd St New York, NY 10001","486 Broadway New York, NY 10013","115 5th Ave New York, NY 10003","770 Broadway New York, NY 10003","264 W 125th St New York, NY 10027","166-02 Jamaica Ave Queens, NY 11432","1988 Broadway New York, NY 10023","4009 30th Ave, Astoria, NY 11103","791 Washington Ave, Brooklyn, NY 11238","415 Tompkins Ave, Brooklyn, NY 11216","39 John St, New York, NY 10038","110 St Marks Pl, New York, NY 10009","220 W 44th St, New York, NY 10036","688 Franklin Ave, Brooklyn, NY 11238","120 Bank St, New York, NY 10014","781 Franklin Ave, Brooklyn, NY 11238","420 Fulton St, Brooklyn, NY 11201","160 Broadway New York, NY 10038","262 Canal St New York, NY 10013","1 Old Fulton St Brooklyn, NY 11201"]

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
        :abbreviation => a[1],
        :latitude => a[2],
        :longitude => a[3]
      )
    end
  end

  def make_destinations(user)
    ["Home", "Work"].each do |n|
      number = rand(15..1700).to_s
      zip_code = rand(10001..11692).to_s
      Destination.create!(
        :name => n,
        :address => ADDRESSES.sample,
        :user_id => user.id
      )
    end
  end

  def make_landings
    [3,4,5,6].each do |id|
      user = User.find(id)
      hour = rand(1..12)
      min = rand(0..59)
      arrival_date = Date.today - rand(0..7)
      arrival_time = arrival_date.to_datetime.change(hour:hour, min:min)
      create_landing(user, arrival_time, arrival_date)
    end
  end

  def create_landing(user, arrival_time, arrival_date)
    Landing.create!(
      :airport_id => Airport.all.sample.id,
      :user_id => user.id,
      :destination_id => user.destinations.first.id,
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
      :user_id => user.id
    )
  end

  def make_common_landing(user, ride, arrival_time)
    Landing.create!(
      :airport_id => Airport.find_by(:abbreviation => "JFK").id,
      :user_id => user.id,
      :destination_id => user.destinations.last.id,
      :complete => true,
      :arrival_date => Date.today - 1,
      :arrival_time => arrival_time,
      :ride_id => ride.id,
      :airline => AIRLINES.sample,
      :flight_num => rand(10000...90000),
      :status => "complete"
    )
  end

end

SeedDatabase.new