require 'rails_helper'

describe "Forecast API endpoint" do
  it "sends the forecast JSON data for the given city", :vcr do
    headers = {
      "Content-Type": "application/json",
      "Accept": "application/json"
    }
    params = {
      location: "denver,co"
    }

    get "/api/v1/forecast", headers: headers, params: params

    expect(response.status).to eq(200)

    forecast = JSON.parse(response.body, symbolize_names: true)

    expect(forecast).to be_a(Hash)
    expect(forecast).to have_key(:data)
    expect(forecast[:data]).to be_a(Hash)
    expect(forecast[:data]).to have_key(:id)
    expect(forecast[:data][:id]).to eq(nil)
    expect(forecast[:data]).to have_key(:type)
    expect(forecast[:data][:type]).to eq("forecast")
    expect(forecast[:data]).to have_key(:attributes)
    expect(forecast[:data][:attributes]).to be_a(Hash)
    expect(forecast[:data][:attributes]).to have_key(:current_weather)
    expect(forecast[:data][:attributes][:current_weather]).to be_a(Hash)

    current_weather = forecast[:data][:attributes][:current_weather]

    expect(current_weather).to have_key(:datetime)
    expect(current_weather[:datetime]).to be_a(String)
    expect(current_weather).to have_key(:sunrise)
    expect(current_weather[:sunrise]).to be_a(String)
    expect(current_weather).to have_key(:sunset)
    expect(current_weather[:sunset]).to be_a(String)
    expect(current_weather).to have_key(:temperature)
    expect(current_weather[:temperature]).to be_a(Float)
    expect(current_weather).to have_key(:feels_like)
    expect(current_weather[:feels_like]).to be_a(Float)
    expect(current_weather).to have_key(:humidity)
    expect(current_weather[:humidity]).to be_an(Numeric)
    expect(current_weather).to have_key(:uvi)
    expect(current_weather[:uvi]).to be_a(Numeric)
    expect(current_weather).to have_key(:visibility)
    expect(current_weather[:visibility]).to be_a(Numeric)
    expect(current_weather).to have_key(:conditions)
    expect(current_weather[:conditions]).to be_a(String)
    expect(current_weather).to have_key(:icon)
    expect(current_weather[:icon]).to be_a(String)

    expect(forecast[:data][:attributes]).to have_key(:daily_weather)
    expect(forecast[:data][:attributes][:daily_weather]).to be_an(Array)
    expect(forecast[:data][:attributes][:daily_weather].count).to eq(5)

    daily_weather = forecast[:data][:attributes][:daily_weather].first

    expect(daily_weather).to have_key(:date)
    expect(daily_weather[:date]).to be_a(String)
    expect(daily_weather).to have_key(:sunrise)
    expect(daily_weather[:sunrise]).to be_a(String)
    expect(daily_weather).to have_key(:sunset)
    expect(daily_weather[:sunset]).to be_a(String)
    expect(daily_weather).to have_key(:max_temp)
    expect(daily_weather[:max_temp]).to be_a(Float)
    expect(daily_weather).to have_key(:min_temp)
    expect(daily_weather[:min_temp]).to be_a(Float)
    expect(daily_weather).to have_key(:conditions)
    expect(daily_weather[:conditions]).to be_a(String)
    expect(daily_weather).to have_key(:icon)
    expect(daily_weather[:icon]).to be_a(String)

    expect(forecast[:data][:attributes]).to have_key(:hourly_weather)
    expect(forecast[:data][:attributes][:hourly_weather]).to be_an(Array)
    expect(forecast[:data][:attributes][:hourly_weather].count).to eq(8)

    hourly_weather = forecast[:data][:attributes][:hourly_weather].first

    expect(hourly_weather).to have_key(:time)
    expect(hourly_weather[:time]).to be_a(String)
    expect(hourly_weather).to have_key(:temperature)
    expect(hourly_weather[:temperature]).to be_a(Float)
    expect(hourly_weather).to have_key(:wind_speed)
    expect(hourly_weather[:wind_speed]).to be_a(String)
    expect(hourly_weather).to have_key(:wind_direction)
    expect(hourly_weather[:wind_direction]).to be_a(String)
    expect(hourly_weather).to have_key(:conditions)
    expect(hourly_weather[:conditions]).to be_a(String)
    expect(hourly_weather).to have_key(:icon)
    expect(hourly_weather[:icon]).to be_a(String)
  end

  it "sends an error message if the coordinates do not exist for given city", :vcr do
    params = {
      location: "invalid city"
    }

    get "/api/v1/forecast", params: params

    expect(response.status).to eq(400)
  end
end
