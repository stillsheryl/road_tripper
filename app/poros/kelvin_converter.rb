class KelvinConverter
  def self.to_fahrenheit(temp)
    (temp - 273.15) * (9 / 5) + 32
  end
end
