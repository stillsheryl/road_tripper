require 'rails_helper'

describe "Weather Facade" do
  it "retrieves the lattitude and longitude for the given city" do
    params = {
      :lat=>39.738453,
      :long=>-104.984853
    }
    results = WeatherFacade.weather(params)

    expect(results).to be_an_instance_of (Weather)
    expect(results.current_weather).to be_a(Hash)
    expect(results.daily_weather).to be_an(Array)
    expect(results.hourly_weather).to be_an(Array)
  end

  it "creates a hash with trip information" do
    params = {
      origin: "Denver,CO",
      destination: "Pueblo,CO"
    }
    city_coordinates = {
      :lat=>39.738453,
      :long=>-104.984853
    }
    driving_time = [6500, "01:44"]
    results = WeatherFacade.weather_at_time(params, city_coordinates, driving_time)

    expect(results).to be_a(Hash)
    expect(results).to have_key(:temperature)
    expect(results[:temperature]).to be_a(Float)
    expect(results).to have_key(:conditions)
    expect(results[:conditions]).to be_a(String)
    expect(results).to have_key(:travel_time)
    expect(results[:travel_time]).to be_a(String)
    expect(results).to have_key(:start_city)
    expect(results[:start_city]).to be_a(String)
    expect(results).to have_key(:end_city)
    expect(results[:end_city]).to be_a(String)
  end
end
