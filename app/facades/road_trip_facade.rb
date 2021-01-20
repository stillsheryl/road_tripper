class RoadTripFacade
  def self.roadtrip_data(params)
    trip = {}
    trip[:start_city] = params[:origin]
    trip[:end_city] = params[:destination]

    times = DirectionsService.get_directions(params)

    return impossible_trip(trip) if times[:error]

    coordinates = GeocodingService.get_coordinates(params[:destination])

    return impossible_trip(trip) if coordinates[:status] == 400

    city_coordinates = create_coordinates(coordinates)
    driving_time = [times[:route][:realTime], times[:route][:formattedTime][0..4]]

    return impossible_trip(trip) if driving_time == "Impossible"

    hours = (driving_time[0].to_f / 3600).round

    return short_trip(trip, city_coordinates, hours, driving_time) if hours <= 48

    return long_trip(trip, city_coordinates, hours, driving_time) if hours > 48
  end

  def self.create_coordinates(coordinates)
    coords = {}
    coords[:lat] = coordinates[:results].first[:locations].first[:latLng][:lat]
    coords[:long] = coordinates[:results].first[:locations].first[:latLng][:lng]

    coords
  end

  def self.impossible_trip(trip)
    trip[:temperature] = ""
    trip[:conditions] = ""
    trip[:travel_time] = "Impossible"

    Roadtrip.new(trip)
  end

  def self.short_trip(trip, city_coordinates, hours, driving_time)
    hourly_weather = WeatherService.hourly_weather(city_coordinates)
    trip[:temperature] = hourly_weather[:hourly][hours][:temp]
    trip[:conditions] = hourly_weather[:hourly][hours][:weather].first[:description]
    trip[:travel_time] = driving_time[1]

    Roadtrip.new(trip)
  end

  def self.long_trip(trip, city_coordinates, hours, driving_time)
    day = hours / 24
    daily_weather = WeatherService.get_weather(city_coordinates)
    trip[:temperature] = daily_weather[:daily][day][:temp][:day]
    trip[:conditions] = daily_weather[:daily][day][:weather].first[:description]
    trip[:travel_time] = driving_time[1]

    Roadtrip.new(trip)
  end
end
