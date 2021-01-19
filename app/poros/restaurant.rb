class Restaurant
  attr_reader :name, :address
  def initialize(info)
    @name = info[:name]
    @address = info[:location][:display_address].join(",")
  end
end
