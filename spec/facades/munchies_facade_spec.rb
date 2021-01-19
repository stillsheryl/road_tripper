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
    # expect(info).to be_a(Hash)
    # expect(info).to have_key(:destination_city)
    # expect(info[:destination_city]).to be_a(String)
    # expect(info).to have_key(:travel_time)
    # expect(info[:travel_time]).to be_a(String)
    #
    # expect(info).to have_key(:forecast)
    # expect(info[:forecast]).to be_a(Hash)
    # expect(info[:forecast]).to have_key(:summary)
    # expect(info[:forecast][:summary]).to be_a(String)
    # expect(info[:forecast]).to have_key(:temperature)
    # expect(info[:forecast][:temperature]).to be_a(Numeric)
    #
    # expect(info).to have_key(:restaurant)
    # expect(info[:restaurant]).to be_a(Hash)
    # expect(info[:restaurant]).to have_key(:name)
    # expect(info[:restaurant][:name]).to be_a(String)
    # expect(info[:restaurant]).to have_key(:address)
    # expect(info[:restaurant][:address]).to be_a(String)
  end
end
