require "rails_helper"

describe "Return index of favorites for a user request" do
  before :each do
    @user = User.create!(name: "Odell", email: "goodboy@ruffruff.com", password: "treats4lyf", password_confirmation: "treats4lyf", api_key: "12345")
    @favorite = @user.favorites.create!(country: "thailand", recipe_link: "recipe.com", recipe_title: "A new recipe")
  end
  
  it "returns all the favorites for a user" do
    
    get "/api/v1/favorites?api_key=12345"

    expect(response).to be_successful

    favs = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(favs).to be_an Array
    favs.each do |fav|
      expect(fav.keys).to eq([:id, :type, :attributes])
      expect(fav[:id]).to eq(@favorite.id.to_s)
      expect(fav[:type]).to eq("favorite")
      expect(fav[:attributes]).to be_a Hash
      expect(fav[:attributes].keys).to eq([:recipe_title, :recipe_link, :country, :created_at])
      expect(fav[:attributes][:country]).to be_a(String)
      expect(fav[:attributes][:recipe_title]).to be_a(String)
      expect(fav[:attributes][:recipe_link]).to be_a(String)
      expect(fav[:attributes][:created_at]).to be_a(String)
    end
  end
  
  it "returns error when the user is not found" do

    get "/api/v1/favorites?api_key=1234"

    expect(response).not_to be_successful
    expect(response.status).to eq(404)

    user = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(user).to be_an Hash
    expect(user.keys).to eq([:id, :type, :attributes])
    expect(user[:attributes].keys).to eq([:message, :status_code])
    expect(user[:id]).to be nil
    expect(user[:type]).to eq("error")
    expect(user[:attributes]).to be_a Hash
    expect(user[:attributes][:message]).to eq("User Not Found")
    expect(user[:attributes][:status_code]).to eq("404")
  end
end