require 'rails_helper'

describe "Weather Facade" do
  it "retrieves the weather for the given city" do
    params = {
      :lat=>39.738453,
      :long=>-104.984853
    }
    results = WeatherFacade.weather(params)

    expect(results).to be_an_instance_of (Weather)
    expect(results.current_weather).to be_a(Hash)
    expect(results.daily_weather).to be_an(Array)
    expect(results.daily_weather.count).to eq(5)
    expect(results.hourly_weather).to be_an(Array)
    expect(results.hourly_weather.count).to eq(8)
  end

  it "returns an error if bad coordinates are given" do
    params = {
      :lat=>456,
      :long=>-104
    }
    results = WeatherFacade.weather(params)

    expect(results).to be_a(Hash)
    expect(results).to have_key(:status)
    expect(results[:status]).to eq(400)
    expect(results).to have_key(:error)
    expect(results[:error]).to eq('Please provide valid latitude and longitude values.')
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

  it "returns nothing if not provided with valid driving time" do
    params = {
      origin: "Denver,CO",
      destination: "London,UK"
    }
    city_coordinates = {
      :lat=>39.738453,
      :long=>-104.984853
    }
    driving_time = "Impossible"
    results = WeatherFacade.weather_at_time(params, city_coordinates, driving_time)

    expect(results[:start_city]).to eq("Denver,CO")
    expect(results[:end_city]).to eq("London,UK")
    expect(results[:temperature]).to eq("")
    expect(results[:conditions]).to eq("")
    expect(results[:travel_time]).to eq("Impossible")
  end

  it "returns an error if given invalid coordinates" do
    params = {
      origin: "Denver,CO",
      destination: "London,UK"
    }
    city_coordinates = {
      :lat=>39.738453,
      :long=>-104.984853
    }
    driving_time = "Impossible"
    results = WeatherFacade.weather_at_time(params, city_coordinates, driving_time)

    expect(results[:start_city]).to eq("Denver,CO")
    expect(results[:end_city]).to eq("London,UK")
    expect(results[:temperature]).to eq("")
    expect(results[:conditions]).to eq("")
    expect(results[:travel_time]).to eq("Impossible")
  end
end
