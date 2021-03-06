require 'rails_helper'

describe "Directions Service" do
  it "sends travel directions for the to city to the from city", :vcr do
    params = {
      origin: "Denver,CO",
      destination: "Pueblo,CO",
      }

    results = DirectionsService.get_directions(params)

    expect(results).to be_a(Hash)
    expect(results).to have_key(:route)
    expect(results[:route]).to be_a(Hash)

    expect(results[:route]).to have_key(:formattedTime)
    expect(results[:route][:formattedTime]).to be_a(String)
  end

  it "sends returns an error if trip is impossible", :vcr do
    params = {
      origin: "Denver,CO",
      destination: "London, UK",
      }

    results = DirectionsService.get_directions(params)

    expect(results).to be_a(Hash)
    expect(results).to have_key(:error)
    expect(results[:error]).to eq("Impossible")
    expect(results).to have_key(:status)
    expect(results[:status]).to eq(400)
  end
end
