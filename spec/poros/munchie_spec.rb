require 'rails_helper'

describe Munchie, type: :poros do
  it "creates a munchie_info object" do
    data = {
      destination_city: "Pueblo, CO",
      travel_time: '02:34',
      forecast: {
        summary: "partly cloudy",
        temperature: 45
      },
      restaurant: {
        name: "Cindy's Chinese",
        address: "123 Main St."
      }
    }

    munchie_info = Munchie.new(data)

    expect(munchie_info.destination_city).to eq("Pueblo, CO")
    expect(munchie_info.travel_time).to eq("02:34")

    expect(munchie_info.forecast).to be_a(Hash)
    expect(munchie_info.forecast).to have_key(:summary)
    expect(munchie_info.forecast[:summary]).to eq("partly cloudy")
    expect(munchie_info.forecast).to have_key(:temperature)
    expect(munchie_info.forecast[:temperature]).to eq(45)

    expect(munchie_info.restaurant).to be_a(Hash)
    expect(munchie_info.restaurant).to have_key(:name)
    expect(munchie_info.restaurant[:name]).to eq("Cindy's Chinese")
    expect(munchie_info.restaurant).to have_key(:address)
    expect(munchie_info.restaurant[:address]).to eq("123 Main St.")
  end
end
