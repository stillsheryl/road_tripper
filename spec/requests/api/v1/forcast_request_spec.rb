require 'rails_helper'

describe "Forecast API" do
  it "sends the forecast for the given city" do
    params = {
      location: "denver,co"
    }
    get "/api/v1/forecast", params: params

    require "pry"; binding.pry

    expect(last_response.status).to eq(200)
    # expect(last_response.body).to be_a(String)

    # response = JSON.parse(last_response.body, symbolize_names: true)
  end
end
