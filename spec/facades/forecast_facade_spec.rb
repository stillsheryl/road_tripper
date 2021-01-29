require 'rails_helper'

describe "Forecast Facade" do
  it "retrieves the weather for the given city", :vcr do
    params = {
      location: "Denver,CO"
    }
    results = ForecastFacade.get_forecast(params)

    expect(results).to be_an_instance_of (Weather)
    expect(results.current_weather).to be_a(Hash)
    expect(results.daily_weather).to be_an(Array)
    expect(results.daily_weather.count).to eq(5)
    expect(results.hourly_weather).to be_an(Array)
    expect(results.hourly_weather.count).to eq(8)
  end
end
