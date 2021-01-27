require 'rails_helper'

describe Weather, type: :poros do
  before :each do
    weather_data = File.read('spec/fixtures/weather_data.json')
    @weather_info = JSON.parse(weather_data, symbolize_names: true)

    @weather = Weather.new(@weather_info)
  end

  it 'can create a Weather object' do
    expect(@weather).to be_an_instance_of(Weather)

    expect(@weather.current_weather).to be_a(Hash)

    current_weather = @weather.current_weather

    expect(current_weather[:datetime]).to eq('2021/01/16  2:36:20 +0000')
    expect(current_weather[:sunrise]).to eq('2021/01/15 13:18:48 +0000')
    expect(current_weather[:sunset]).to eq('2021/01/15 23:31:51 +0000')
    expect(current_weather[:temperature]).to eq(35.910000000000025)
    expect(current_weather[:feels_like]).to eq(30.879999999999995)
    expect(current_weather[:humidity]).to eq(42)
    expect(current_weather[:uvi]).to eq(0)
    expect(current_weather[:visibility]).to eq(10000)
    expect(current_weather[:conditions]).to eq('clear sky')
    expect(current_weather[:icon]).to eq('01n')

    expect(@weather.daily_weather).to be_an(Array)
    expect(@weather.daily_weather.count).to eq(5)
    expect(@weather.daily_weather.first).to be_an_instance_of(DailyWeather)

    expect(@weather.hourly_weather).to be_an(Array)
    expect(@weather.hourly_weather.count).to eq(8)
    expect(@weather.hourly_weather.first).to be_an_instance_of(HourlyWeather)

    hourly_weather = @weather.hourly_weather.first
    expect(hourly_weather.conditions).to eq("clear sky")
    expect(hourly_weather.icon).to eq("01n")
    expect(hourly_weather.temperature).to eq(35.910000000000025)
    expect(hourly_weather.time).to eq(" 2:00:00")
    expect(hourly_weather.wind_direction).to eq("from W")
    expect(hourly_weather.wind_speed).to eq("3.07 mph")

    daily_weather = @weather.daily_weather.first
    expect(daily_weather.conditions).to eq("clear sky")
    expect(daily_weather.date).to eq("2021/01/15")
    expect(daily_weather.icon).to eq("01d")
    expect(daily_weather.max_temp).to eq(42.160000000000025)
    expect(daily_weather.min_temp).to eq(35.79000000000002)
    expect(daily_weather.sunrise).to eq("2021/01/15 13:18:48 +0000")
    expect(daily_weather.sunset).to eq("2021/01/15 23:31:51 +0000")
  end
end
