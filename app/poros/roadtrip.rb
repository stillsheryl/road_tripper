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
    @weather_at_eta = weather_info(params) if params[:temperature]!= ""
    @id = nil
  end

  def weather_info(params)
    {
      temperature: KelvinConverter.fahrenheit(params[:temperature]),
      conditions: params[:conditions]
    }
  end
end
