require 'rails_helper'

describe "Geocoding Facade" do
  it "retrieves the lattitude and longitude for the given city" do
    params = {
      location: "denver,co"
    }
    results = GeocodingFacade.coordinates(params[:location])

    expect(results).to be_an (Hash)
    expect(results[:lat]).to be_a(Float)
    expect(results[:long]).to be_a(Float)
  end
end
