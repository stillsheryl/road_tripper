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

    body = JSON.parse(response.body, symbolize_names: true)

    impossible_error_codes = [601, 602, 603, 610, 402]

    if impossible_error_codes.include?(body[:info][:statuscode]) || body[:route][:realTime] == 10000000
      { error: 'Impossible', status: 400 }
    else
      body
    end
  end
end
