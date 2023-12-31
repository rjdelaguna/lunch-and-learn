require "rails_helper"

describe "Create a new user request" do
  it "creates a new user when all information is good" do
    user = {
      "name": "Odell",
      "email": "goodboy@ruffruff.com",
      "password": "treats4lyf",
      "password_confirmation": "treats4lyf"
    }
    post "/api/v1/users", params: user, as: :json

    expect(response).to be_successful

    user = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(user).to be_an Hash
    expect(user.keys).to eq([:id, :type, :attributes])
    expect(user[:attributes].keys).to eq([:name, :email, :api_key])
    expect(user[:id]).to eq(User.last.id.to_s)
    expect(user[:type]).to eq("user")
    expect(user[:attributes]).to be_a Hash
    expect(user[:attributes][:name]).to be_a String
    expect(user[:attributes][:email]).to be_a String
    expect(user[:attributes][:api_key]).to be_a String
  end
  
  it "returns error when email is already in use" do
    user = {
      "name": "Odell",
      "email": "goodboy@ruffruff.com",
      "password": "treats4lyf",
      "password_confirmation": "treats4lyf"
    }

    post "/api/v1/users", params: user, as: :json
    
    post "/api/v1/users", params: user, as: :json

    expect(response).not_to be_successful
    expect(response.status).to eq(401)

    user = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(user).to be_an Hash
    expect(user.keys).to eq([:id, :type, :attributes])
    expect(user[:attributes].keys).to eq([:message, :status_code])
    expect(user[:id]).to be nil
    expect(user[:type]).to eq("error")
    expect(user[:attributes]).to be_a Hash
    expect(user[:attributes][:message]).to eq("Credentials Invalid")
    expect(user[:attributes][:status_code]).to eq("401")
  end
  
  it "returns error when password and confirmation do not match" do
    user = {
      "name": "Odell",
      "email": "goodboy@ruffruff.com",
      "password": "treats4lyf",
      "password_confirmation": "not_the_same"
    }

    post "/api/v1/users", params: user, as: :json

    expect(response).not_to be_successful
    expect(response.status).to eq(401)

    user = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(user).to be_an Hash
    expect(user.keys).to eq([:id, :type, :attributes])
    expect(user[:attributes].keys).to eq([:message, :status_code])
    expect(user[:id]).to be nil
    expect(user[:type]).to eq("error")
    expect(user[:attributes]).to be_a Hash
    expect(user[:attributes][:message]).to eq(["Password confirmation doesn't match Password"])
    expect(user[:attributes][:status_code]).to eq("401")
  end
end