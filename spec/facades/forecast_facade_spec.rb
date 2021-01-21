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

  it 'gets coordinates from coordinates service call', :vcr do
    coordinates = {:info=>
      {:statuscode=>0,
       :messages=>[]},
     :results=>
      [{:providedLocation=>{:location=>"Denver,CO"},
        :locations=>
         [{
           :latLng=>{:lat=>39.738453, :lng=>-104.984853},
           :displayLatLng=>{:lat=>39.738453, :lng=>-104.984853}},
           {
       :latLng=>{:lat=>39.738453, :lng=>-104.984853},
       :displayLatLng=>{:lat=>39.738453, :lng=>-104.984853},
       }]}]}
    coordinates = ForecastFacade.create_coordinates(coordinates)

    expect(coordinates).to be_a(Hash)
    expect(coordinates).to have_key(:lat)
    expect(coordinates).to have_key(:long)
  end
end
