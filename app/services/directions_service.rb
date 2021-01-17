class DirectionsService
  def self.conn
    Faraday.new(url: 'http://www.mapquestapi.com') do |f|
      f.params["key"] = ENV["GEOCODING_API_KEY"]
    end
  end

  def self.get_directions(params)
    response = conn.get('/directions/v2/route') do |req|
      req.params["from"] = params[:origin]
      req.params["to"] = params[:destination]
    end

    JSON.parse(response.body, symbolize_names: true)
  end
end
