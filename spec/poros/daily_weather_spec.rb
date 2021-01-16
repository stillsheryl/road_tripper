require 'rails_helper'

describe 'DailyWeather PORO' do
  it 'can create a DailyWeather object' do
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

    daily_weather = DailyWeather.new(weather_data)

    expect(daily_weather.daily_date).to eq("2021/01/15")
    expect(daily_weather.daily_sunrise).to eq('Fri, 15 Jan 2021 13:18:48 +0000')
    expect(daily_weather.daily_sunset).to eq('Fri, 15 Jan 2021 23:31:51 +0000')
    expect(daily_weather.daily_max_temp).to eq(283.31)
    expect(daily_weather.daily_min_temp).to eq(276.94)
    expect(daily_weather.daily_conditions).to eq('clear sky')
    expect(daily_weather.daily_icon).to eq('01d')
    expect(daily_weather.id).to eq(nil)
  end
end
