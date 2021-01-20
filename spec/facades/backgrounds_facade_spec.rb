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
end
