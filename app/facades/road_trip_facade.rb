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

    create_trip(trip, city_coordinates, driving_time)
  end

  def self.create_coordinates(coordinates)
    lat_lng_map = coordinates[:results].first[:locations].first[:latLng]
    coords = {lat: lat_lng_map[:lat], long: lat_lng_map[:lng]}
  end

  def self.create_trip(trip, city_coordinates, driving_time)
    hours = (driving_time[0].to_f / 3600).round
    if driving_time == "Impossible"
      impossible_trip(trip)
    elsif hours <= 48
      short_trip(trip, city_coordinates, hours, driving_time)
    elsif hours > 48
      long_trip(trip, city_coordinates, hours, driving_time)
    end
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
    daily_weather = WeatherService.get_weather(city_coordinates)[:daily][day]

    results = {
      temperature: daily_weather[:temp][:day],
      conditions: daily_weather[:weather].first[:description],
      travel_time:  driving_time[1]
    }

    trip_params = trip.merge(results)

    Roadtrip.new(trip_params)
  end
end
