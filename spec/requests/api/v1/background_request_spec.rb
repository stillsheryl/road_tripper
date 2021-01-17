require 'rails_helper'

describe "Background API" do
  it "sends the image JSON data for the given city" do
    params = {
      location: "denver,co"
    }

    get "/api/v1/backgrounds", params: params

    expect(response.status).to eq(200)

    image = JSON.parse(response.body, symbolize_names: true)

    expect(image).to be_a(Hash)
    expect(image).to have_key(:data)
    expect(image[:data]).to be_a(Hash)
    expect(image[:data]).to have_key(:id)
    expect(image[:data][:id]).to eq(nil)
    expect(image[:data]).to have_key(:type)
  end
end
