require 'rails_helper'

describe "Geocoding Service" do
  it "sends the lattitude and longitude for the given city", :vcr do
    params = {
      location: "denver,co"
    }
    results = GeocodingService.get_coordinates(params[:location])

    expect(results).to be_a(Hash)
    expect(results).to have_key(:lat)
    expect(results[:lat]).to be_a(Float)
    expect(results).to have_key(:long)
    expect(results[:long]).to be_a(Float)
  end

  it "returns an error if not a valid city with a state", :vcr do
    params = {
      location: "geocolgical, co"
    }
    response = GeocodingService.get_coordinates(params[:location])

    expect(response).to be_a(Hash)
    expect(response[:message]).to eq("Unknown Location: geocolgical, co")
    expect(response[:status]).to eq(400)
  end

  it "returns an error if not a valid city and is gibberish", :vcr do
    params = {
      location: "hfysavew"
    }

    response = GeocodingService.get_coordinates(params[:location])

    expect(response).to be_a(Hash)
    expect(response[:message]).to eq("Unknown Location: hfysavew")
    expect(response[:status]).to eq(400)
  end

  it "returns an error if symbols entered and not a valid city", :vcr do
    params = {
      location: "$^*&$"
    }

    response = GeocodingService.get_coordinates(params[:location])

    expect(response).to be_a(Hash)
    expect(response[:message]).to eq("Unknown Location: $^*&$")
    expect(response[:status]).to eq(400)
  end

  it "returns an error if user doesn't input a city", :vcr do
    params = {
      location: ""
    }

    response = GeocodingService.get_coordinates(params[:location])

    expect(response).to be_a(Hash)
    expect(response[:message]).to eq("Unknown Location: ")
    expect(response[:status]).to eq(400)
  end

  it "retrieves weather for given coordinates" do
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

    weather = GeocodingService.create_coordinates(coordinates)

    expect(weather).to be_a(Hash)
    expect(weather).to have_key(:lat)
    expect(weather[:lat]).to be_a(Float)
    expect(weather).to have_key(:long)
    expect(weather[:long]).to be_a(Float)
  end
end
