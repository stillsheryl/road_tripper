require 'rails_helper'

describe "Photo Facade" do
  it "retrieves an image for the given city", :vcr do
    params = {
      location: "denver,co"
    }
    weather = "clear sky"
    photo = PhotoFacade.photo(params, weather)

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

  it "sends an error when no matches for a city,state search", :vcr do
    params = {
      location: "fwuehPHVUE9Wobwiovgbrqb"
    }
    weather = ""
    photo = PhotoFacade.photo(params, weather)

    expect(photo).to be_a(Hash)
    expect(photo).to have_key(:status)
    expect(photo[:status]).to eq(400)
    expect(photo).to have_key(:error)
    expect(photo[:error]).to eq('Please provide a valid city for the search.')
  end
end
