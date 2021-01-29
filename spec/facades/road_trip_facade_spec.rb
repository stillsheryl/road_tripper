require 'rails_helper'

describe 'RoadTrip Facade' do
  it 'retrieves roadtrip data for a given location', :vcr do
    params = {
      origin: 'Denver,CO',
      destination: 'Pueblo,CO'
    }
    roadtrip = RoadTripFacade.roadtrip_data(params)

    expect(roadtrip).to be_a(Roadtrip)
    expect(roadtrip.start_city).to eq('Denver,CO')
    expect(roadtrip.end_city).to eq('Pueblo,CO')
    expect(roadtrip.travel_time).to be_a(String)
    expect(roadtrip.weather_at_eta).to be_a(Hash)
    expect(roadtrip.weather_at_eta).to have_key(:temperature)
    expect(roadtrip.weather_at_eta[:temperature]).to be_a(Numeric)
    expect(roadtrip.weather_at_eta).to have_key(:conditions)
    expect(roadtrip.weather_at_eta[:conditions]).to be_a(String)
  end

  it 'returns an error if invalid city is given', :vcr do
    params = {
      origin: 'Denver,CO',
      destination: 'Invalid City,CO'
    }
    roadtrip = RoadTripFacade.roadtrip_data(params)

    expect(roadtrip).to be_a(Roadtrip)
    expect(roadtrip.start_city).to eq('Denver,CO')
    expect(roadtrip.end_city).to eq('Invalid City,CO')
    expect(roadtrip.travel_time).to eq('Impossible')
  end

  it 'creates trip from data for valid trip', :vcr do
    trip = {
      start_city: "Denver,CO",
      end_city: "Pueblo,CO"
    }
    city_coordinates = {
      lat: 38.265425,
      long: -104.610415
    }
    driving_time = [6738, "01:44"]

    roadtrip = RoadTripFacade.create_trip(trip, city_coordinates, driving_time)

    expect(roadtrip).to be_a(Roadtrip)
    expect(roadtrip.start_city).to eq('Denver,CO')
    expect(roadtrip.end_city).to eq('Pueblo,CO')
    expect(roadtrip.travel_time).to be_a(String)
    expect(roadtrip.weather_at_eta).to be_a(Hash)
    expect(roadtrip.weather_at_eta).to have_key(:temperature)
    expect(roadtrip.weather_at_eta[:temperature]).to be_a(Numeric)
    expect(roadtrip.weather_at_eta).to have_key(:conditions)
    expect(roadtrip.weather_at_eta[:conditions]).to be_a(String)
  end

  it 'creates error from data for invalid trip', :vcr do
    trip = {
      start_city: "Denver,CO",
      end_city: "London,UK"
    }
    city_coordinates = {
      lat: 51.50015,
      long: -0.12624
    }
    driving_time = "Impossible"

    roadtrip = RoadTripFacade.create_trip(trip, city_coordinates, driving_time)

    expect(roadtrip).to be_a(Roadtrip)
    expect(roadtrip.start_city).to eq('Denver,CO')
    expect(roadtrip.end_city).to eq('London,UK')
    expect(roadtrip.travel_time).to eq('Impossible')
  end

  it 'creates trip with travel time under 48 hours', :vcr do
    trip = {
      start_city: "Denver,CO",
      end_city: "Los Angeles,CA"
    }
    city_coordinates = {
      lat: 34.052238,
      long: -118.243344
    }
    hours = 14
    driving_time = [51900, "14:25"]

    roadtrip = RoadTripFacade.short_trip(trip, city_coordinates, hours, driving_time)

    expect(roadtrip).to be_a(Roadtrip)
    expect(roadtrip.start_city).to eq('Denver,CO')
    expect(roadtrip.end_city).to eq('Los Angeles,CA')
    expect(roadtrip.travel_time).to be_a(String)
    expect(roadtrip.weather_at_eta).to be_a(Hash)
    expect(roadtrip.weather_at_eta).to have_key(:temperature)
    expect(roadtrip.weather_at_eta[:temperature]).to be_a(Numeric)
    expect(roadtrip.weather_at_eta).to have_key(:conditions)
    expect(roadtrip.weather_at_eta[:conditions]).to be_a(String)
  end

  it 'creates trip with travel time over 48 hours', :vcr do
    trip = {
      start_city: "Anchorage,AK",
      end_city: "Los Angeles,CA"
    }
    city_coordinates = {
      lat: 34.052238,
      long: -118.243344
    }
    hours = 58
    driving_time = [209700, "58:15"]

    roadtrip = RoadTripFacade.long_trip(trip, city_coordinates, hours, driving_time)

    expect(roadtrip).to be_a(Roadtrip)
    expect(roadtrip.start_city).to eq('Anchorage,AK')
    expect(roadtrip.end_city).to eq('Los Angeles,CA')
    expect(roadtrip.travel_time).to be_a(String)
    expect(roadtrip.weather_at_eta).to be_a(Hash)
    expect(roadtrip.weather_at_eta).to have_key(:temperature)
    expect(roadtrip.weather_at_eta[:temperature]).to be_a(Numeric)
    expect(roadtrip.weather_at_eta).to have_key(:conditions)
    expect(roadtrip.weather_at_eta[:conditions]).to be_a(String)
  end
end
