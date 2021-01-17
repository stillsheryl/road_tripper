class Roadtrip
  attr_reader :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta,
              :id

  def initialize(params)
    @start_city = params[:start_city]
    @end_city = params[:end_city]
    @travel_time = params[:travel_time]
    @weather_at_eta = weather_info(params)
    @id = nil
  end

  def weather_info(params)
    {
      temperature: fahrenheit(params[:temperature]),
      conditions: params[:conditions]
    }
  end

  def fahrenheit(temp)
    (temp - 273.15) * (9 / 5) + 32
  end
end
