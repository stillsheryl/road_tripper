require 'rails_helper'

describe "Geocoding Service" do
  it "sends the lattitude and longitude for the given city" do
    params = {
      location: "denver,co"
    }
    results = GeocodingService.get_coordinates(params)

    expect(results).to be_a(Hash)
    expect(results).to have_key(:results)
    expect(results[:results]).to be_an(Array)

    coordinates = results[:results].first

    expect(coordinates).to have_key(:locations)
    expect(coordinates[:locations]).to be_an(Array)

    expect(coordinates[:locations].first).to have_key(:latLng)
    expect(coordinates[:locations].first[:latLng]).to be_a(Hash)

    expect(coordinates[:locations].first[:latLng]).to have_key(:lat)
    expect(coordinates[:locations].first[:latLng][:lat]).to be_a(Float)

    expect(coordinates[:locations].first[:latLng]).to have_key(:lng)
    expect(coordinates[:locations].first[:latLng][:lng]).to be_a(Float)
  end
end
