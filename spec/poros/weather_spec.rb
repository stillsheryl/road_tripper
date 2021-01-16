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

    expect(current_weather[:datetime]).to eq('2021/01/16  2:36:20')
    expect(current_weather[:sunrise]).to eq('2021/01/15 13:18:48')
    expect(current_weather[:sunset]).to eq('2021/01/15 23:31:51')
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
  end

  describe 'instance methods' do
  #   it 'current_weather_hash' do
  #     expect(@weather.current_weather_hash(@weather_info)).to be_a(Hash)
  #   end
  #
  #   it 'daily_weather_for_5_days' do
  #     expect(@weather.daily_weather_for_5_days(@weather_info)).to be_an(Array)
  #   end
  #
  #   it 'hourly_weather_for_8_hours' do
  #     expect(@weather.hourly_weather_for_8_hours(@weather_info)).to be_an(Array)
  #   end

    it 'fahrenheit' do
      temp = 271.63
      expect(@weather.fahrenheit(temp).round(1)).to eq(30.5)
    end
  end
end
