class RestaurantsService
  def self.conn
    Faraday.new(url: 'https://api.yelp.com') do |f|
      f.headers["Authorization"] = "Bearer #{ENV['YELP_API_KEY']}"
    end
  end

  def self.get_restaurants(params, time)
    response = conn.get('/v3/businesses/search') do |f|
      f.params["location"] = params[:end]
      f.params['open_at'] = time
      f.params['categories'] = params[:food]
    end

    restaurants = JSON.parse(response.body, symbolize_names: true)
  end
end
