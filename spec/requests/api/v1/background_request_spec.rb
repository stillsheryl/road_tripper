require 'rails_helper'

describe "Background API endpoint" do
  it "sends the image JSON data for the given city" do
    headers = {
      "Content-Type": "application/json",
      "Accept": "application/json"
    }
    params = {
      location: "denver,co"
    }

    get "/api/v1/backgrounds", headers: headers, params: params

    expect(response.status).to eq(200)

    image = JSON.parse(response.body, symbolize_names: true)

    expect(image).to be_a(Hash)
    expect(image).to have_key(:data)
    expect(image[:data]).to be_a(Hash)
    expect(image[:data]).to have_key(:id)
    expect(image[:data][:id]).to eq(nil)
    expect(image[:data]).to have_key(:type)
    expect(image[:data]).to have_key(:type)
    expect(image[:data][:type]).to eq("image")
    expect(image[:data]).to have_key(:attributes)
    expect(image[:data][:attributes]).to be_a(Hash)
    expect(image[:data][:attributes]).to have_key(:image)
    expect(image[:data][:attributes][:image]).to be_a(Hash)

    photo = image[:data][:attributes][:image]

    expect(photo).to have_key(:location)
    expect(photo[:location]).to be_a(String)
    expect(photo).to have_key(:image_url)
    expect(photo[:image_url]).to be_a(String)
    expect(photo).to have_key(:credit)
    expect(photo[:credit]).to be_a(Hash)

    credit = photo[:credit]
    expect(credit).to have_key(:photographer_name)
    expect(credit[:photographer_name]).to be_a(String)
    expect(credit).to have_key(:photographer_profile_link)
    expect(credit[:photographer_profile_link]).to be_a(String)
    expect(credit).to have_key(:source_link)
    expect(credit[:source_link]).to be_a(String)
  end

  xit "sends the image JSON data for the given city" do
    params = {
      location: "dbwuqiCBVYWrbretr"
    }

    get "/api/v1/backgrounds", params: params

    expect(response.status).to eq(400)

    image = JSON.parse(response.body, symbolize_names: true)

    expect(image).to be_a(Hash)
  end
end
