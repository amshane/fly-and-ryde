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
    create_neighborhoods
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

  def create_neighborhoods
    create_manhattan_neighborhoods
    create_brooklyn_neighborhoods
    create_queens_neighborhoods
  end

  def create_manhattan_neighborhoods
    Area.create([
      {borough: "Manhattan", neighborhood: "Battery Park City"},
      {borough: "Manhattan", neighborhood: "Chelsea"},
      {borough: "Manhattan", neighborhood: "East Harlem"},
      {borough: "Manhattan", neighborhood: "East Village"},
      {borough: "Manhattan", neighborhood: "Financial District"},
      {borough: "Manhattan", neighborhood: "Flatiron"},
      {borough: "Manhattan", neighborhood: "Gramercy"},
      {borough: "Manhattan", neighborhood: "Hamilton Heights"},
      {borough: "Manhattan", neighborhood: "Harlem"},
      {borough: "Manhattan", neighborhood: "Inwood"},
      {borough: "Manhattan", neighborhood: "Kips Bay"},
      {borough: "Manhattan", neighborhood: "Lower East Side"},
      {borough: "Manhattan", neighborhood: "Manhattan Valley"},
      {borough: "Manhattan", neighborhood: "Midtown East"},
      {borough: "Manhattan", neighborhood: "Midtown West"},
      {borough: "Manhattan", neighborhood: "Morningside Heights"},
      {borough: "Manhattan", neighborhood: "Murray Hill"},
      {borough: "Manhattan", neighborhood: "NoHo"},
      {borough: "Manhattan", neighborhood: "Roosevelt Island"},
      {borough: "Manhattan", neighborhood: "Soho"},
      {borough: "Manhattan", neighborhood: "Tribeca"},
      {borough: "Manhattan", neighborhood: "Union Square"},
      {borough: "Manhattan", neighborhood: "Upper East Side"},
      {borough: "Manhattan", neighborhood: "Upper West Side"},
      {borough: "Manhattan", neighborhood: "Washington Heights"},
      {borough: "Manhattan", neighborhood: "West Village"}
    ])
  end

  def create_brooklyn_neighborhoods
    Area.create([
      {borough: "Brooklyn", neighborhood: "Bay Ridge"},
      {borough: "Brooklyn", neighborhood: "Bedford Stuyvesant"},
      {borough: "Brooklyn", neighborhood: "Bensonhurst"},
      {borough: "Brooklyn", neighborhood: "Boerum Hill"},
      {borough: "Brooklyn", neighborhood: "Borough Park"},
      {borough: "Brooklyn", neighborhood: "Brighton Beach"},
      {borough: "Brooklyn", neighborhood: "Brooklyn Heights"},
      {borough: "Brooklyn", neighborhood: "Brownsville"},
      {borough: "Brooklyn", neighborhood: "Bushwick"},
      {borough: "Brooklyn", neighborhood: "Canarsie"},
      {borough: "Brooklyn", neighborhood: "Carroll Gardens"},
      {borough: "Brooklyn", neighborhood: "Clinton Hill"},
      {borough: "Brooklyn", neighborhood: "Cobble Hill"},
      {borough: "Brooklyn", neighborhood: "Coney Island"},
      {borough: "Brooklyn", neighborhood: "Crown Heights"},
      {borough: "Brooklyn", neighborhood: "Ditmas Park"},
      {borough: "Brooklyn", neighborhood: "Dumbo"},
      {borough: "Brooklyn", neighborhood: "Dyker Heights"},
      {borough: "Brooklyn", neighborhood: "East New York"},
      {borough: "Brooklyn", neighborhood: "Flatbush"},
      {borough: "Brooklyn", neighborhood: "Fort Greene"},
      {borough: "Brooklyn", neighborhood: "Fort Hamilton"},
      {borough: "Brooklyn", neighborhood: "Gravesend"},
      {borough: "Brooklyn", neighborhood: "Greenpoint"},
      {borough: "Brooklyn", neighborhood: "Kensington"},
      {borough: "Brooklyn", neighborhood: "Midwood"},
      {borough: "Brooklyn", neighborhood: "Ocean Hill"},
      {borough: "Brooklyn", neighborhood: "Park Slope"},
      {borough: "Brooklyn", neighborhood: "Prospect Heights"},
      {borough: "Brooklyn", neighborhood: "Prospect Lefferts Gardens"},
      {borough: "Brooklyn", neighborhood: "Red Hook"},
      {borough: "Brooklyn", neighborhood: "Sheepshead Bay"},
      {borough: "Brooklyn", neighborhood: "Sunset Park"},
      {borough: "Brooklyn", neighborhood: "Vinegar Hill"},
      {borough: "Brooklyn", neighborhood: "Williamsburg"},
      {borough: "Brooklyn", neighborhood: "Windsor Terrace"}
    ])
  end

  def create_queens_neighborhoods
    Area.create([
      {borough: "Queens", neighborhood: "Astoria"},
      {borough: "Queens", neighborhood: "Bayside"},
      {borough: "Queens", neighborhood: "Bellerose"},
      {borough: "Queens", neighborhood: "Briarwood"},
      {borough: "Queens", neighborhood: "College Point"},
      {borough: "Queens", neighborhood: "Corona"},
      {borough: "Queens", neighborhood: "Douglaston"},
      {borough: "Queens", neighborhood: "Elmhurst"},
      {borough: "Queens", neighborhood: "Far Rockaway"},
      {borough: "Queens", neighborhood: "Floral Park"},
      {borough: "Queens", neighborhood: "Flushing"},
      {borough: "Queens", neighborhood: "Forest Hills"},
      {borough: "Queens", neighborhood: "Fresh Meadows"},
      {borough: "Queens", neighborhood: "Glen Oaks"},
      {borough: "Queens", neighborhood: "Glendale"},
      {borough: "Queens", neighborhood: "Hollis"},
      {borough: "Queens", neighborhood: "Howard Beach"},
      {borough: "Queens", neighborhood: "Jackson Heights"},
      {borough: "Queens", neighborhood: "Jamaica"},
      {borough: "Queens", neighborhood: "Kew Gardens"},
      {borough: "Queens", neighborhood: "Kew Gardens Hills"},
      {borough: "Queens", neighborhood: "Little Neck"},
      {borough: "Queens", neighborhood: "Long Island City"},
      {borough: "Queens", neighborhood: "Maspeth"},
      {borough: "Queens", neighborhood: "Middle Village"},
      {borough: "Queens", neighborhood: "Ozone Park"},
      {borough: "Queens", neighborhood: "Queens Village"},
      {borough: "Queens", neighborhood: "Rego Park"},
      {borough: "Queens", neighborhood: "Richmond Hill"},
      {borough: "Queens", neighborhood: "Ridgewood"},
      {borough: "Queens", neighborhood: "St. Albans"},
      {borough: "Queens", neighborhood: "Sunnyside"},
      {borough: "Queens", neighborhood: "Utopia"},
      {borough: "Queens", neighborhood: "Whitestone"},
      {borough: "Queens", neighborhood: "Woodhaven"},
      {borough: "Queens", neighborhood: "Woodside"}
    ])
  end

end

SeedDatabase.new