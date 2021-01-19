class Munchie
  attr_reader :destination_city, :travel_time, :forecast, :restaurant, :id
  def initialize(data)
    @destination_city = data[:destination_city]
    @travel_time = data[:travel_time]
    @forecast = data[:forecast]
    @restaurant = data[:restaurant]
    @id = nil
  end
end
