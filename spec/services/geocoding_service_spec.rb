require 'rails_helper'

describe "Geocoding Service" do
  it "sends the lattitude and longitude for the given city" do
    params = {
      location: "denver,co"
    }
    results = GeocodingService.get_coordinates(params[:location])

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

  it "returns an error if not a valid city" do
    params = {
      location: "geocolgical, co"
    }
    response = GeocodingService.get_coordinates(params[:location])

    expect(response).to be_a(Hash)
    expect(response[:message]).to eq("Unknown Location: geocolgical, co")
    expect(response[:status]).to eq(400)
  end

  it "returns an error if not a valid city" do
    params = {
      location: "hfysavew"
    }

    response = GeocodingService.get_coordinates(params[:location])

    expect(response).to be_a(Hash)
    expect(response[:message]).to eq("Unknown Location: hfysavew")
    expect(response[:status]).to eq(400)
  end

  it "returns an error if symbols entered and not a valid city" do
    params = {
      location: "$^*&$"
    }

    response = GeocodingService.get_coordinates(params[:location])

    expect(response).to be_a(Hash)
    expect(response[:message]).to eq("Unknown Location: $^*&$")
    expect(response[:status]).to eq(400)
  end

  it "returns an error if user doesn't input a city" do
    params = {
      location: ""
    }

    response = GeocodingService.get_coordinates(params[:location])

    expect(response).to be_a(Hash)
    expect(response[:message]).to eq("Unknown Location: ")
    expect(response[:status]).to eq(400)
  end
end
