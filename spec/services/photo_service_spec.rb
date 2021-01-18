require 'rails_helper'

describe "Photo Service" do
  it "sends a photo for the given city when given city,state" do
    params = {
      location: "denver,co"
    }
    photo = PhotoService.get_photo(params)

    expect(photo).to be_a(Hash)
    expect(photo).to have_key(:results)
    expect(photo[:results]).to be_an(Array)

    first_photo = photo[:results].first

    expect(first_photo).to have_key(:urls)
    expect(first_photo[:urls]).to be_a(Hash)
    expect(first_photo[:urls]).to have_key(:regular)
    expect(first_photo[:urls][:regular]).to be_a(String)

    expect(first_photo).to have_key(:user)
    expect(first_photo[:user]).to be_a(Hash)
    expect(first_photo[:user]).to have_key(:name)
    expect(first_photo[:user][:name]).to be_a(String)
    expect(first_photo[:user]).to have_key(:links)
    expect(first_photo[:user][:links]).to be_a(Hash)
    expect(first_photo[:user][:links]).to have_key(:html)
    expect(first_photo[:user][:links][:html]).to be_a(String)
  end

  it "returns no results it invalid search location" do
    params = {
      location: "hfewyegheh"
    }
    photo = PhotoService.get_photo(params)

    expect(photo).to be_a(Hash)
    expect(photo).to have_key(:results)
    expect(photo[:results]).to eq([])
    expect(photo[:total]).to eq(0)
  end
end
