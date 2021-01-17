class WeatherService
  def self.conn
    Faraday.new(url: 'https://api.openweathermap.org') do |f|
      f.params['appid'] = ENV['WEATHER_API_KEY']
    end
  end

  def self.get_weather(params)
    response = conn.get('/data/2.5/onecall') do |req|
      req.params['lat'] = params[:lat]
      req.params['lon'] = params[:long]
      req.params['exclude'] = 'minutely,alerts'
    end

    JSON.parse(response.body, symbolize_names: true)
  end
end
