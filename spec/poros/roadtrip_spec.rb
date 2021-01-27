require 'rails_helper'

describe Roadtrip, type: :poros do
  before :each do
    roadtrip_data = {
      :temperature=>278.8,
      :conditions=>"scattered clouds",
      :travel_time=>"01:44",
      :start_city=>"Denver,CO",
      :end_city=>"Pueblo,CO"
    }

    @roadtrip = Roadtrip.new(roadtrip_data)
  end

  it 'can create an HourlyWeather object' do
    expect(@roadtrip).to be_an_instance_of(Roadtrip)
    expect(@roadtrip.start_city).to eq("Denver,CO")
    expect(@roadtrip.end_city).to eq("Pueblo,CO")
    expect(@roadtrip.travel_time).to eq("01:44")
    expect(@roadtrip.weather_at_eta).to be_a(Hash)
    expect(@roadtrip.weather_at_eta[:temperature]).to eq(37.650000000000034)
    expect(@roadtrip.weather_at_eta[:conditions]).to eq("scattered clouds")
  end
end
