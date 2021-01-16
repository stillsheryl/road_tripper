require 'rails_helper'

describe "Forecast API" do
  it "sends the forecast for the given city" do
    params = {
      location: "denver,co"
    }

    get "/api/v1/forecast", params: params

    expect(response.status).to eq(200)

    forecast = JSON.parse(response.body, symbolize_names: true)

    expect(forecast).to be_a(String)
  end
end
