require 'rails_helper'

describe "Backgrounds Facade" do
  it "retrieves photo for a given location and its current weather", :vcr do
    params = {
      location: "Denver,CO"
    }
    photo = BackgroundsFacade.get_photo(params)

    expect(photo).to be_a(Photo)
    expect(photo.image).to be_a(Hash)
  end

  it "retrieves weather for given coordinates", :vcr do
    coordinates = {:info=>
      {:statuscode=>0,
       :messages=>[]},
     :results=>
      [{:providedLocation=>{:location=>"Denver,CO"},
        :locations=>
         [{
           :latLng=>{:lat=>39.738453, :lng=>-104.984853},
           :displayLatLng=>{:lat=>39.738453, :lng=>-104.984853}},
           {
       :latLng=>{:lat=>39.738453, :lng=>-104.984853},
       :displayLatLng=>{:lat=>39.738453, :lng=>-104.984853},
       }]}]}

    weather = BackgroundsFacade.get_weather(coordinates)

    expect(weather).to be_a(Hash)
  end
end
