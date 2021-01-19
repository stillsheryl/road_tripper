class MunchiesFacade
  def self.compile_data(params, weather_at_dest, restaurant)
    info = {
      destination_city: params[:end],
      travel_time: weather_at_dest[:travel_time],
      forecast: {
        summary: weather_at_dest[:conditions],
        temperature: fahrenheit(weather_at_dest[:temperature]).round
      },
      restaurant: {
        name: restaurant.name,
        address: restaurant.address
      }
    }
    Munchie.new(info)
  end

  def self.fahrenheit(temp)
    (temp - 273.15) * (9 / 5) + 32
  end
end
