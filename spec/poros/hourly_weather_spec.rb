require 'rails_helper'

describe HourlyWeather, type: :poros do
  before :each do
    weather_data = {
      :dt=>1610762400,
      :temp=>277.06,
      :feels_like=>272.03,
      :pressure=>1015,
      :humidity=>42,
      :dew_point=>266.2,
      :uvi=>0,
      :clouds=>0,
      :visibility=>10000,
      :wind_speed=>3.07,
      :wind_deg=>279,
      :weather=>[{:id=>800, :main=>"Clear", :description=>"clear sky", :icon=>"01n"}],
      :pop=>0
    }

    @hourly_weather = HourlyWeather.new(weather_data)
  end

  it 'can create an HourlyWeather object' do
    expect(@hourly_weather).to be_an_instance_of(HourlyWeather)
    expect(@hourly_weather.time).to eq(" 2:00:00")
    expect(@hourly_weather.temperature).to eq(35.910000000000025)
    expect(@hourly_weather.wind_speed).to eq("3.07 mph")
    expect(@hourly_weather.wind_direction).to eq("from W")
    expect(@hourly_weather.conditions).to eq('clear sky')
    expect(@hourly_weather.icon).to eq('01n')
  end

  describe 'instance methods' do
    it 'wind_direction_from_integer' do
      expect(@hourly_weather.wind_direction_from_integer(35)).to eq("NE")
    end
  end
end
