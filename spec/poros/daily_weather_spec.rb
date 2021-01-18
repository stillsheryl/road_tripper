require 'rails_helper'

describe DailyWeather, type: :poros do
  before :each do
    weather_data = {
      :dt=>1610733600,
      :sunrise=>1610716728,
      :sunset=>1610753511,
      :temp=>{:day=>282.87, :min=>276.94, :max=>283.31, :night=>277.03,  :eve=>279.09, :morn=>277.37},
      :feels_like=>{:day=>275.57, :night=>272.64, :eve=>274.48, :morn=>272.75},
      :pressure=>1014,
      :humidity=>44,
      :dew_point=>266.59,
      :wind_speed=>7.21,
      :wind_deg=>288,
      :weather=>[{:id=>800, :main=>"Clear", :description=>"clear sky", :icon=>"01d"}],
      :clouds=>0,
      :pop=>0,
      :uvi=>2.29
    }

    @daily_weather = DailyWeather.new(weather_data)
  end

  it 'can create a DailyWeather object' do
    expect(@daily_weather).to be_an_instance_of(DailyWeather)
    expect(@daily_weather.date).to eq("2021/01/15")
    expect(@daily_weather.sunrise).to eq('2021/01/15 13:18:48 +0000')
    expect(@daily_weather.sunset).to eq('2021/01/15 23:31:51 +0000')
    expect(@daily_weather.max_temp).to eq(42.160000000000025)
    expect(@daily_weather.min_temp).to eq(35.79000000000002)
    expect(@daily_weather.conditions).to eq('clear sky')
    expect(@daily_weather.icon).to eq('01d')
  end

  describe 'instance methods' do
    it 'fahrenheit' do
      temp = 271.63
      expect(@daily_weather.fahrenheit(temp).round(1)).to eq(30.5)
    end
  end
end
