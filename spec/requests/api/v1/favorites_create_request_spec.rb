require "rails_helper"

describe "Create a new user request" do
  before :each do
    @user = User.create(name: "Odell", email: "goodboy@ruffruff.com", password: "treats4lyf", password_confirmation: "treats4lyf", api_key: "12345")
  end

  it "creates a new favorite for a user" do
    favorite = {
      "api_key": "12345",
      "country": "thailand",
      "recipe_link": "recipe.com",
      "recipe_title": "A new recipe"
    }
    post "/api/v1/favorites", params: favorite, as: :json

    expect(response).to be_successful

    fav = JSON.parse(response.body, symbolize_names: true)
    expect(fav).to be_an Hash
    expect(fav.keys).to eq([:success])
    expect(fav[:success]).to eq("Favorite added successfully")
  end
  
  it "returns error when api not associated with user" do
    favorite = {
      "api_key": "1234",
      "country": "thailand",
      "recipe_link": "recipe.com",
      "recipe_title": "A new recipe"
    }
    post "/api/v1/favorites", params: favorite, as: :json

    expect(response).not_to be_successful
    expect(response.status).to eq(404)

    fav = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(fav).to be_an Hash
    expect(fav.keys).to eq([:id, :type, :attributes])
    expect(fav[:attributes].keys).to eq([:message, :status_code])
    expect(fav[:id]).to be nil
    expect(fav[:type]).to eq("error")
    expect(fav[:attributes]).to be_a Hash
    expect(fav[:attributes][:message]).to eq("User Not Found")
    expect(fav[:attributes][:status_code]).to eq("404")
  end
end