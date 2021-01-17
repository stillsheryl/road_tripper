require 'rails_helper'

describe "User Registration API endpoint" do
  it "when a user provides an email and password, their user information is returned, including an API key" do
    params = {
      email: "whatever@example.com",
      password: "password",
      password_confirmation: "password"
    }

    post "/api/v1/users", params: params

    expect(response.status).to eq(201)

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

  it "returns an error if passwords don't match" do
    params = {
      email: "whatever@example.com",
      password: "password",
      password_confirmation: "password1"
    }

    post "/api/v1/users", params: params

    expect(response.status).to eq(400)

    user = JSON.parse(response.body, symbolize_names: true)

    expect(user).to be_a(Hash)
    expect(user[:error]).to eq("Password confirmation doesn't match Password")
    expect(user[:status]).to eq(400)
  end

  it "returns an error if email is not unique" do
    user1 = User.create!(email: "whatever@example.com", password: "sneaky_password", api_key: "longspecialcodehere")

    params = {
      email: "whatever@example.com",
      password: "password",
      password_confirmation: "password"
    }

    post "/api/v1/users", params: params

    expect(response.status).to eq(400)

    user = JSON.parse(response.body, symbolize_names: true)

    expect(user).to be_a(Hash)
    expect(user[:error]).to eq("Email has already been taken")
    expect(user[:status]).to eq(400)
  end

  it "returns an error if a field is missing" do
    params = {
      email: "",
      password: "password",
      password_confirmation: "password"
    }

    post "/api/v1/users", params: params

    expect(response.status).to eq(400)

    user = JSON.parse(response.body, symbolize_names: true)

    expect(user).to be_a(Hash)
    expect(user[:error]).to eq("Email can't be blank")
    expect(user[:status]).to eq(400)
  end
end
