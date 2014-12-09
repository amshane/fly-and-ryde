class SeedDatabase
  
  USERS = [
    ["Katie", "Hoffman", "7202327272"], 
    ["Harold", "Cooper", "3038956008"], 
    ["Amanda", "Chang", "2125657878"], 
    ["Rodrigo", "Figueroa", "7804342323"], 
    ["Blake", "Deboer", "3035556767"]]

  AIRPORTS = [
    ["JFK International Airport", "JFK", 40.6413111, -73.77813909999999],
    ["Newark International Airport", "EWR", 40.6895314, -74.1744624],
    ["LaGuardia Airport","LGA", 40.7769271, -73.8739659]]

  ADDRESS_NAMES = ["Home", "Work", "School", "Gym", "Mom's"]

  ADDRESSES = ["1440 Broadway", "205 W. 39th St", "370 W. 46th St", "11 W. 53rd St", "1379 Avenue of the Americas"]

  BOROUGHS = ["Manhattan", "Manhattan", "Manhattan", "Manhattan", "Manhattan"]

  NEIGHBORHOODS = ["Midtown", "Midtown", "Hells Kitchen", "Midtown", "Midtown"]

  LATITUDES = [40.754498, 40.754691, 40.760652, 40.7614151, 40.763625]

  LONGITUDES = [-73.986599, -73.98884, -73.990428, -73.9776194, -73.9777336]

  ARRIVAL_TIMES = [(Date.today + 5).to_datetime.change(hour:8,min:15), (Date.today + 5).to_datetime.change(hour:11,min:15), (Date.today + 5).to_datetime.change(hour:14,min:15), (Date.today + 5).to_datetime.change(hour:17,min:15), (Date.today + 5).to_datetime.change(hour:20,min:15)]

  ARRIVAL_DATES = [(Date.today + 5), (Date.today + 5), (Date.today + 5), (Date.today + 5), (Date.today + 5)]

  AIRLINES = ["Delta", "Spirit", "JetBlue", "American", "Southwest"]

  FLIGHT_NUMBERS = ["5678", "903", "7269", "1302", "4687"]

  def initialize
    make_airports
    make_users_and_destinations
    make_landings
  end

  def make_users_and_destinations
    USERS.each do |u| 
      user = User.create!(
        :first_name => u[0], 
        :last_name => u[1], 
        :phone_number => u[2]
      )
      make_destinations(user)
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
    ADDRESS_NAMES.each.with_index do |n, i|
      Destination.create!(
        :name => n,
        :address => ADDRESSES[i],
        :user_id => user.id,
        :borough => "Manhattan",
        :neighborhood => "Midtown",
        :lat => LATITUDES[i],
        :long => LONGITUDES[i]
      )
    end
  end

  def make_landings
    [1,2,3,4,5].each.with_index do |id, i|
      user = User.find(id)
      arrival_date = ARRIVAL_DATES[i]
      arrival_time = ARRIVAL_TIMES[i]
      create_landing(user, arrival_time, arrival_date)
    end
  end

  def create_landing(user, arrival_time, arrival_date)
    Landing.create!(
      :airport_id => 1,
      :user_id => user.id,
      :destination_id => user.destinations.first.id,
      :arrival_time => arrival_time,
      :arrival_date => arrival_date,
      :airline => AIRLINES.sample,
      :flight_num => rand(10000...90000)
    )
  end

end

SeedDatabase.new