require 'rails_helper'

describe "Road Trip API endpoint" do
  before :each do
    User.create!(email: "whatever@example.com", password: "password", api_key: "longspecialcodehere")
    @headers = {
      "Content-Type": "application/json",
      "Accept": "application/json"
    }
  end

  it "returns road trip data JSON when valid input is given" do
    params = {
      "origin": "Denver,CO",
      "destination": "Pueblo,CO",
      "api_key": "longspecialcodehere"
      }

    post "/api/v1/road_trip", headers: @headers, params: params.to_json

    expect(response.status).to eq(201)

    roadtrip = JSON.parse(response.body, symbolize_names: true)

    expect(roadtrip).to be_a(Hash)
    expect(roadtrip).to have_key(:data)
    expect(roadtrip[:data]).to be_a(Hash)
    expect(roadtrip[:data]).to have_key(:type)
    expect(roadtrip[:data][:type]).to eq("roadtrip")
    expect(roadtrip[:data]).to have_key(:id)
    expect(roadtrip[:data][:id]).to eq(nil)
    expect(roadtrip[:data]).to have_key(:attributes)
    expect(roadtrip[:data][:attributes]).to be_a(Hash)

    attributes = roadtrip[:data][:attributes]

    expect(attributes).to have_key(:start_city)
    expect(attributes[:start_city]).to be_a(String)
    expect(attributes).to have_key(:end_city)
    expect(attributes[:end_city]).to be_a(String)
    expect(attributes).to have_key(:travel_time)
    expect(attributes[:travel_time]).to be_a(String)
    expect(attributes).to have_key(:weather_at_eta)
    expect(attributes[:weather_at_eta]).to be_a(Hash)
    expect(attributes[:weather_at_eta]).to have_key(:temperature)
    expect(attributes[:weather_at_eta][:temperature]).to be_a(Float)
    expect(attributes[:weather_at_eta]).to have_key(:conditions)
    expect(attributes[:weather_at_eta][:conditions]).to be_a(String)
  end

  it "returns an error if an invalid api_key is given" do
    params = {
      "origin": "Denver,CO",
      "destination": "Pueblo,CO",
      "api_key": "wrongapikey"
      }

    post "/api/v1/road_trip", headers: @headers, params: params.to_json

    expect(response.status).to eq(401)

    roadtrip = JSON.parse(response.body, symbolize_names: true)

    expect(roadtrip).to be_a(Hash)
    expect(roadtrip[:error]).to eq("A valid API key is required.")
    expect(roadtrip[:status]).to eq(401)
  end

  it "returns an error if no api_key is given" do
    params = {
      "origin": "Denver,CO",
      "destination": "Pueblo,CO",
      "api_key": ""
      }

    post "/api/v1/road_trip", headers: @headers, params: params.to_json

    expect(response.status).to eq(401)

    roadtrip = JSON.parse(response.body, symbolize_names: true)

    expect(roadtrip).to be_a(Hash)
    expect(roadtrip[:error]).to eq("A valid API key is required.")
    expect(roadtrip[:status]).to eq(401)
  end
end
