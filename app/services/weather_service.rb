class WeatherService
  def self.conn
    Faraday.new(url: 'https://api.openweathermap.org') do |f|
      f.params['appid'] = ENV['WEATHER_API_KEY']
    end
  end

  def self.get_weather(params)
    if check_lat_lon(params)
      response = conn.get('/data/2.5/onecall') do |req|
        req.params['lat'] = params[:lat]
        req.params['lon'] = params[:long]
        req.params['exclude'] = 'minutely,alerts'
      end

      JSON.parse(response.body, symbolize_names: true)
    else
      {
        error: 'Please provide valid latitude and longitude values.',
        status: 400
      }
    end
  end

  def self.hourly_weather(params)
    response = conn.get('/data/2.5/onecall') do |req|
      req.params['lat'] = params[:lat]
      req.params['lon'] = params[:long]
      req.params['exclude'] = 'current,minutely,daily,alerts'
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.check_lat_lon(params)
    params[:lat].to_i.between?(-90, 90) && params[:long].to_i.between?(-180, 180)
  end
end
