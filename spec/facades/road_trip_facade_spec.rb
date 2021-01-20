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
end
