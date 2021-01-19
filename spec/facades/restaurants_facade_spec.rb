require 'rails_helper'

describe "Restaurants Facade" do
  it "retrieves restaurant info for the given city" do
    params = {
      end: "Pueblo,CO",
      food: "chinese"
      }
    time = 1611083833

    restaurant = RestaurantFacade.get_restaurant(params, time)

    expect(restaurant).to be_an_instance_of(Restaurant)
    expect(restaurant.name).to be_a(String)
    expect(restaurant.address).to be_a(String)
  end
end
