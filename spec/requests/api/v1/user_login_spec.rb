require 'rails_helper'

describe "User Login API endpoint" do
  before :each do
    User.create!(email: "whatever@example.com", password: "password", api_key: "longspecialcodehere")

    @headers = {
      "Content-Type": "application/json",
      "Accept": "application/json"
    }
  end

  it "when a user provides a valid email and password, their user information is returned, including an API key" do
    params = {
      "email": "whatever@example.com",
      "password": "password"
    }

    post "/api/v1/sessions", headers: @headers, params: params.to_json

    expect(response.status).to eq(200)

    user = JSON.parse(response.body, symbolize_names: true)

    expect(user).to be_a(Hash)
    expect(user).to have_key(:data)
    expect(user[:data]).to be_a(Hash)
    expect(user[:data]).to have_key(:type)
    expect(user[:data][:type]).to eq("users")
    expect(user[:data]).to have_key(:id)
    expect(user[:data][:id]).to be_a(String)
    expect(user[:data]).to have_key(:attributes)
    expect(user[:data][:attributes]).to be_a(Hash)
    expect(user[:data][:attributes]).to have_key(:email)
    expect(user[:data][:attributes][:email]).to be_a(String)
    expect(user[:data][:attributes]).to have_key(:api_key)
    expect(user[:data][:attributes][:api_key]).to be_a(String)
  end

  it "when a user provides an invalid email an error is received" do
    @params = {
      "email": "whatever111@example.com",
      "password": "password"
    }

    post "/api/v1/sessions", headers: @headers, params: @params.to_json

    expect(response.status).to eq(400)

    user = JSON.parse(response.body, symbolize_names: true)

    expect(user).to be_a(Hash)
    expect(user[:error]).to eq("You have entered an invalid email or password. Please try again.")
    expect(user[:status]).to eq(400)
  end

  it "when a user provides an incorrect password an error is received" do
    @params = {
      "email": "whatever@example.com",
      "password": "wrongpassword"
    }

    post "/api/v1/sessions", headers: @headers, params: @params.to_json

    expect(response.status).to eq(400)

    user = JSON.parse(response.body, symbolize_names: true)

    expect(user).to be_a(Hash)
    expect(user[:error]).to eq("You have entered an invalid email or password. Please try again.")
    expect(user[:status]).to eq(400)
  end

  it "when a user skips a field an error is received" do
    @params = {
      "email": "",
      "password": "password"
    }

    post "/api/v1/sessions", headers: @headers, params: @params.to_json

    expect(response.status).to eq(400)

    user = JSON.parse(response.body, symbolize_names: true)

    expect(user).to be_a(Hash)
    expect(user[:error]).to eq("You have entered an invalid email or password. Please try again.")
    expect(user[:status]).to eq(400)
  end
end
