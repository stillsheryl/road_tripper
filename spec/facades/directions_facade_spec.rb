require 'rails_helper'

describe "Directions Facade" do
  it "retrieves time for the trip in two formats" do
    params = {
      origin: "Denver,CO",
      destination: "Pueblo,CO"
    }
    times = DirectionsFacade.directions_time(params)

    expect(times).to be_an(Array)
    expect(times[0]).to be_an(Integer)
    expect(times[1]).to be_a(String)
  end

  it "gives an error if invalid cities are provided" do
    params = {
      origin: "Denver,CO",
      destination: "Lodon, UK"
    }
    times = DirectionsFacade.directions_time(params)

    expect(times).to eq("Impossible")
  end
end
