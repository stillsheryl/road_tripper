require 'rails_helper'

describe 'Weather PORO' do
  it 'can create a Weather object' do
    weather_data = File.read('spec/fixtures/weather_data.json')
    weather_info = JSON.parse(weather_data, symbolize_names: true)

    weather = Weather.new(weather_info)

    expect(weather.datetime).to eq('Sat, 16 Jan 2021 02:36:20 +0000')
    expect(weather.sunrise).to eq('Fri, 15 Jan 2021 13:18:48 +0000')
    expect(weather.sunset).to eq('Fri, 15 Jan 2021 23:31:51 +0000')
    expect(weather.temperature).to eq(277.06)
    expect(weather.feels_like).to eq(272.03)
    expect(weather.humidity).to eq(42)
    expect(weather.uvi).to eq(0)
    expect(weather.visibility).to eq(10000)
    expect(weather.conditions).to eq('clear sky')
    expect(weather.icon).to eq('01n')

    expect(weather.daily_weather).to be_an(Array)
    expect(weather.daily_weather.count).to eq(5)
    expect(weather.daily_weather.first).to be_an_instance_of(DailyWeather)

    expect(weather.hourly_weather).to be_an(Array)
    expect(weather.hourly_weather.count).to eq(8)
    expect(weather.hourly_weather.first).to be_an_instance_of(HourlyWeather)
  end
end
