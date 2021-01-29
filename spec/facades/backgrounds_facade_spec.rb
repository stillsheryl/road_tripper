require 'rails_helper'

describe "Backgrounds Facade" do
  it "retrieves photo for a given location and its current weather", :vcr do
    params = {
      location: "Denver,CO"
    }
    photo = BackgroundsFacade.get_photo(params)

    expect(photo).to be_a(Photo)
    expect(photo.image).to be_a(Hash)
  end

  it "returns an error if a given location has ban coordinates", :vcr do
    params = {
      location: "nonamecity"
    }
    error = BackgroundsFacade.get_photo(params)

    expect(error).to be_a(Hash)
    expect(error).to have_key(:message)
    expect(error[:message]).to eq("Unknown Location: nonamecity")
    expect(error).to have_key(:status)
    expect(error[:status]).to eq(400)
  end

  it "retrieves weather for given coordinates", :vcr do
    coordinates = {:lat=>39.738453, :long=>-104.984853}

    weather = BackgroundsFacade.get_weather(coordinates)

    expect(weather).to be_a(Hash)
    expect(weather).to have_key(:current)
    expect(weather).to have_key(:hourly)
    expect(weather).to have_key(:daily)
  end

  it "retrieves photo with weather and search location", :vcr do
    weather_data = File.read('spec/fixtures/weather_data.json')
    weather_info = JSON.parse(weather_data, symbolize_names: true)
    params = {
      location: "denver, co"
    }

    photo = BackgroundsFacade.get_photo_info(weather_info, params)

    expect(photo).to be_a(Hash)
    expect(photo).to have_key(:results)
    expect(photo[:results]).to be_an(Array)
    expect(photo[:results].first).to have_key(:urls)
  end
end
