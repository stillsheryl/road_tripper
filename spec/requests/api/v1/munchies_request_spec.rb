require 'rails_helper'

describe "Munchie API endpoint" do
  it "sends the destination city, travel time, restaurant info, and forecast JSON data" do
    headers = {
      "Content-Type": "application/json",
      "Accept": "application/json"
    }
    params = {
      start: "denver,co",
      end: "pueble,co",
      food: "chinese"
    }

    get "/api/v1/munchies", headers: headers, params: params

    expect(response.status).to eq(200)

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data).to be_a(Hash)
    expect(data).to have_key(:data)
    expect(data[:data]).to be_a(Hash)
    expect(data[:data]).to have_key(:id)
    expect(data[:data][:id]).to eq(nil)
    expect(data[:data]).to have_key(:type)
    expect(data[:data][:type]).to eq("munchie")
    expect(data[:data]).to have_key(:attributes)
    expect(data[:data][:attributes]).to be_a(Hash)

    expect(data[:data][:attributes]).to have_key(:destination_city)
    expect(data[:data][:attributes][:destination_city]).to be_a(String)
    expect(data[:data][:attributes]).to have_key(:travel_time)
    expect(data[:data][:attributes][:travel_time]).to be_a(String)
    expect(data[:data][:attributes]).to have_key(:forecast)
    expect(data[:data][:attributes][:forecast]).to be_a(Hash)

    current_weather = data[:data][:attributes][:forecast]

    expect(current_weather).to have_key(:summary)
    expect(current_weather[:summary]).to be_a(String)
    expect(current_weather).to have_key(:temperature)
    expect(current_weather[:temperature]).to be_an(Integer)

    expect(data[:data][:attributes]).to have_key(:restaurant)
    expect(data[:data][:attributes][:restaurant]).to be_a(Hash)

    restaurant = data[:data][:attributes][:restaurant]

    expect(restaurant).to have_key(:name)
    expect(restaurant[:name]).to be_a(String)
    expect(restaurant).to have_key(:address)
    expect(restaurant[:address]).to be_an(String)
  end
end
