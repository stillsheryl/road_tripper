require 'rails_helper'

describe "Geocoding Facade" do
  it "retrieves the lattitude and longitude for the given city", :vcr do
    params = {
      location: "denver,co"
    }
    results = GeocodingFacade.coordinates(params[:location])

    expect(results).to be_an (Hash)
    expect(results[:lat]).to be_a(Float)
    expect(results[:long]).to be_a(Float)
  end

  it "returns an error if an invalid city", :vcr do
    params = {
      location: "hfysavew"
    }
    response = GeocodingFacade.coordinates(params[:location])

    expect(response).to be_a(Hash)
    expect(response[:message]).to eq("Unknown Location: hfysavew")
    expect(response[:status]).to eq(400)
  end
end
