require 'rails_helper'

describe "Directions Service" do
  it "sends travel directions for the to city to the from city" do
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
end
