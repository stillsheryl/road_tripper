class PhotoService
  def self.conn
    Faraday.new(url: 'https://api.unsplash.com') do |f|
      f.params["client_id"] = ENV["PHOTO_API_KEY"]
    end
  end

  def self.get_photo(params)
    response = conn.get('/search/photos') do |req|
      req.params["query"] = params[:location]
    end

    JSON.parse(response.body, symbolize_names: true)
  end
end
