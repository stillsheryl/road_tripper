require 'rails_helper'

describe "Munchies Facade" do
  it "compiles data for the munchies endpoint" do
    params = {
      end: "pueblo, co"
    }
    weather_at_dest = {
      temperature: 272.66,
      conditions: "overcast clouds",
      travel_time: "01:44"
    }
    restaurant = Restaurant.new(
      {
        :name=>"Wonderful Bistro",
        :location=>
         {:address1=>"4602 N Elizabeth St",
          :display_address=>["4602 N Elizabeth St", "Ste 120", "Pueblo, CO 81008"]}
      }
    )

    info = MunchiesFacade.compile_data(params, weather_at_dest, restaurant)

    expect(info).to be_a(Munchie)
  end
end
