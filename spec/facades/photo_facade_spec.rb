require 'rails_helper'

describe "Photo Facade" do
  it "retrieves an image for the given city" do
    params = {
      location: "denver,co"
    }
    photo = PhotoFacade.photo(params)

    expect(photo).to be_an_instance_of (Photo)
    expect(photo.image).to be_a(Hash)
    expect(photo.image).to have_key(:location)
    expect(photo.image[:location]).to be_a(String)
    expect(photo.image).to have_key(:image_url)
    expect(photo.image[:image_url]).to be_a(String)
    expect(photo.image).to have_key(:credit)
    expect(photo.image[:credit]).to be_a(Hash)

    credit = photo.image[:credit]
    expect(credit).to have_key(:photographer_name)
    expect(credit[:photographer_name]).to be_a(String)
    expect(credit).to have_key(:photographer_profile_link)
    expect(credit[:photographer_profile_link]).to be_a(String)
    expect(credit).to have_key(:source_link)
    expect(credit[:source_link]).to be_a(String)
  end
end
