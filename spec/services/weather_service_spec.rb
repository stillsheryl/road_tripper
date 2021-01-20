require 'rails_helper'

describe "Weather Service" do
  it "sends the forecast for the given city when given lat/long params", :vcr do
    params = {
      lat: "33",
      long: "-94"
    }
    weather = WeatherService.get_weather(params)

    expect(weather).to be_a(Hash)
    expect(weather).to have_key(:lat)
    expect(weather[:lat]).to be_an(Integer)
    expect(weather).to have_key(:lon)
    expect(weather[:lon]).to be_an(Integer)

    current_weather = weather[:current]

    expect(weather).to have_key(:current)
    expect(current_weather).to be_a(Hash)
    expect(current_weather).to have_key(:dt)
    expect(current_weather[:dt]).to be_an(Integer)
    expect(current_weather).to have_key(:sunrise)
    expect(current_weather[:sunrise]).to be_an(Integer)
    expect(current_weather).to have_key(:sunset)
    expect(current_weather[:sunset]).to be_an(Integer)
    expect(current_weather).to have_key(:temp)
    expect(current_weather[:temp]).to be_an(Float)
    expect(current_weather).to have_key(:feels_like)
    expect(current_weather[:feels_like]).to be_a(Numeric)
    expect(current_weather).to have_key(:humidity)
    expect(current_weather[:humidity]).to be_an(Integer)
    expect(current_weather).to have_key(:uvi)
    expect(current_weather[:uvi]).to be_a(Numeric)
    expect(current_weather).to have_key(:visibility)
    expect(current_weather[:visibility]).to be_an(Integer)
    expect(current_weather).to have_key(:weather)
    expect(current_weather[:weather]).to be_an(Array)
    expect(current_weather[:weather].first).to have_key(:description)
    expect(current_weather[:weather].first[:description]).to be_a(String)
    expect(current_weather[:weather].first).to have_key(:icon)
    expect(current_weather[:weather].first[:icon]).to be_a(String)

    expect(weather).to have_key(:daily)
    expect(weather[:daily]).to be_an(Array)

    daily_weather = weather[:daily].first

    expect(weather[:daily].first).to have_key(:dt)
    expect(daily_weather[:dt]).to be_an(Integer)
    expect(daily_weather).to have_key(:sunrise)
    expect(daily_weather[:sunrise]).to be_an(Integer)
    expect(daily_weather).to have_key(:sunset)
    expect(daily_weather[:sunset]).to be_an(Integer)

    expect(daily_weather[:temp]).to have_key(:max)
    expect(daily_weather[:temp][:max]).to be_a(Float)
    expect(daily_weather[:temp]).to have_key(:min)
    expect(daily_weather[:temp][:min]).to be_a(Numeric)

    expect(daily_weather[:weather]).to be_an(Array)
    expect(daily_weather[:weather].first).to be_a(Hash)
    expect(daily_weather[:weather].first).to have_key(:description)
    expect(daily_weather[:weather].first[:description]).to be_a(String)
    expect(daily_weather[:weather].first).to have_key(:icon)
    expect(daily_weather[:weather].first[:icon]).to be_a(String)

    expect(weather).to have_key(:hourly)
    expect(weather[:hourly]).to be_an(Array)

    hourly_weather = weather[:hourly].first

    expect(hourly_weather).to have_key(:dt)
    expect(hourly_weather[:dt]).to be_an(Integer)
    expect(hourly_weather).to have_key(:temp)
    expect(hourly_weather[:temp]).to be_a(Float)
    expect(hourly_weather).to have_key(:wind_speed)
    expect(hourly_weather[:wind_speed]).to be_a(Float)
    expect(hourly_weather).to have_key(:wind_deg)
    expect(hourly_weather[:wind_deg]).to be_a(Integer)
    expect(hourly_weather[:weather].first).to have_key(:description)
    expect(hourly_weather[:weather].first[:description]).to be_a(String)
    expect(hourly_weather[:weather].first).to have_key(:icon)
    expect(hourly_weather[:weather].first[:icon]).to be_a(String)

    expect(weather).to_not have_key(:minutely)
    expect(weather).to_not have_key(:alerts)
  end

  it 'sends an error message if the coordinates do not exist for given city' do
    params = {
      lat: '500',
      long: '-94'
    }
    weather = WeatherService.get_weather(params)

    expect(weather).to be_a(Hash)
    expect(weather).to have_key(:status)
    expect(weather[:status]).to eq(400)
    expect(weather).to have_key(:error)
    expect(weather[:error]).to eq('Please provide valid latitude and longitude values.')
  end

  it "sends the hourly forecast for the given city when given lat/long params", :vcr do
    params = {
      lat: "33",
      long: "-94"
    }
    weather = WeatherService.hourly_weather(params)

    expect(weather).to be_a(Hash)
    expect(weather).to have_key(:lat)
    expect(weather[:lat]).to be_an(Integer)
    expect(weather).to have_key(:lon)
    expect(weather[:lon]).to be_an(Integer)
    expect(weather).to have_key(:hourly)
    expect(weather[:hourly]).to be_an(Array)

    hourly_weather = weather[:hourly].first

    expect(hourly_weather).to be_a(Hash)
    expect(hourly_weather).to have_key(:temp)
    expect(hourly_weather[:temp]).to be_a(Float)
    expect(hourly_weather).to have_key(:weather)
    expect(hourly_weather[:weather]).to be_an(Array)
    expect(hourly_weather[:weather].first).to have_key(:description)
    expect(hourly_weather[:weather].first[:description]).to be_a(String)

    expect(weather).to_not have_key(:minutely)
    expect(weather).to_not have_key(:alerts)
    expect(weather).to_not have_key(:current)
    expect(weather).to_not have_key(:daily)
  end

  it 'sends an error message if the coordinates do not exist for given city' do
    params = {
      lat: '500',
      long: '-94'
    }
    weather = WeatherService.hourly_weather(params)

    expect(weather).to be_a(Hash)
    expect(weather).to have_key(:status)
    expect(weather[:status]).to eq(400)
    expect(weather).to have_key(:error)
    expect(weather[:error]).to eq('Please provide valid latitude and longitude values.')
  end

  it 'returns false if the coordinates do not exist for given city' do
    params = {
      lat: '500',
      long: '-94'
    }
    weather = WeatherService.check_lat_lon(params)

    expect(weather).to eq(false)
  end

  it 'returns true if the coordinates do not exist for given city' do
    params = {
      lat: "93",
      long: "-140"
    }
    weather = WeatherService.check_lat_lon(params)

    expect(weather).to eq(false)
  end
end
