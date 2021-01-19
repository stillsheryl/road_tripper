class Api::V1::MunchiesController <ApplicationController
  def index
    travel_times = DirectionsFacade.directions_time_start_end(params)

    hours = (travel_times[0].to_f / 3600).round

    arrival_time = Time.now + hours.hours

    DateTime.strptime(arrival_time.to_s,'%s')

    conn = Faraday.new(url: 'https://api.yelp.com') do |f|
      f.headers["Authorization"] = "Bearer #{ENV['YELP_API_KEY']}"
    end

    response = conn.get('/v3/businesses/search') do |f|
      f.params["location"] = params[:end]
      f.params['open_at'] = arrival_time.to_i
      f.params['categories'] = params[:food]
    end

    restaurants = JSON.parse(response.body, symbolize_names: true)

    
  end
end



# the destination city
# estimated travel time from start city to destination city
# the name and address of a restaurant serving THE SPECIFIED TYPE of cuisine that WILL BE OPEN at your estimated time of arrival.
# the current forecast of the destination city
