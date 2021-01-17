require 'rails_helper'

describe "Directions Facade" do
  it "retrieves time for the trip in two formats" do
    params = {
      origin: "Denver,CO",
      destination: "Pueblo,CO"
    }
    times = DirectionsFacade.directions_time(params)

    expect(times).to be_an (Array)
    expect(times[0]).to be_an(Integer)
    expect(times[1]).to be_a(String)
  end
end
