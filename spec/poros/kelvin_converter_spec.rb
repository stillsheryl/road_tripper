require 'rails_helper'

describe HourlyWeather, type: :poros do
  describe 'class methods' do
    it 'fahrenheit' do
      temp = 271.63
      expect(KelvinConverter.fahrenheit(temp).round(1)).to eq(30.5)
    end
  end
end
