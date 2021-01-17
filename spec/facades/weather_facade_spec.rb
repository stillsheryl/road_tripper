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
end
