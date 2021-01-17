require 'rails_helper'

describe "User Registration API endpoint" do
  it "when a user provides an email and password, their user information is returned, including an API key" do
    params = {
      email: whatever@example.com,
      password: password,
      password_confirmation: password
    }

    get "/api/v1/user", params: params

    expect(response.status).to eq(201)

    user = JSON.parse(response.body, symbolize_names: true)

    expect(user).to be_a(Hash)
    expect(user).to have_key(:data)
    expect(user[:data]).to be_a(Hash)
    expect(user[:data]).to have_key(:id)
    expect(user[:data][:id]).to eq(1)
    expect(forecast[:data]).to have_key(:type)
    expect(forecast[:data][:type]).to eq("users")
    expect(forecast[:data]).to have_key(:attributes)
    expect(forecast[:data][:attributes]).to be_a(Hash)
    expect(forecast[:data][:attributes]).to have_key(:email)
    expect(forecast[:data][:attributes][:email]).to be_a(String)
    expect(forecast[:data][:attributes]).to have_key(:api_key)
    expect(forecast[:data][:attributes][:api_key]).to be_a(String)
  end
end
