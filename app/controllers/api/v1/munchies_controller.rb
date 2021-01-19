require 'time'

class Api::V1::MunchiesController <ApplicationController
  def index
    travel_times = DirectionsFacade.directions_time_start_end(params)

    hours = (travel_times[0].to_f / 3600).round

    arrival_time = Time.now + hours.hours

    arrival_time_sec = arrival_time.to_i

    restaurant = RestaurantFacade.get_restaurant(params, arrival_time_sec)

    city_coordinates = GeocodingFacade.coordinates(params[:end])

    weather_at_dest = WeatherFacade.weather_at_destination(city_coordinates, travel_times)
require "pry"; binding.pry
    munchies = MunchiesFacade.compile_data(params, weather_at_dest, restaurant)

    data = MunchiesSerializer.new(munchies).to_json

    render json: data
  end
end



# the destination city
# estimated travel time from start city to destination city
# the name and address of a restaurant serving THE SPECIFIED TYPE of cuisine that WILL BE OPEN at your estimated time of arrival.
# the current forecast of the destination city
