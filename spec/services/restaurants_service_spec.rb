require 'rails_helper'

describe "Restaurants Service" do
  it "sends restaurant infor for the given city that are open at a specified time" do
    params = {
      end: "Pueblo,CO",
      food: "chinese"
      }
    time = 1611083833

    results = RestaurantsService.get_restaurants(params, time)

    expect(results).to be_a(Hash)
    expect(results).to have_key(:businesses)
    expect(results[:businesses]).to be_an(Array)

    business = results[:businesses].first

    expect(business).to have_key(:name)
    expect(business[:name]).to be_a(String)
    expect(business).to have_key(:location)
    expect(business[:location]).to be_a(Hash)
    expect(business[:location]).to have_key(:display_address)
    expect(business[:location][:display_address]).to be_an(Array)
    expect(business[:location][:display_address].first).to be_a(String)
  end
end
