require "rails_helper"

describe "Recipes request" do
  it "accepts query param of country name", :vcr do
    get "/api/v1/recipes?country=thailand"

    expect(response).to be_successful

    recipes = JSON.parse(response.body, symbolize_names: true)[:data]

    recipes.each do |recipe|
      expect(recipe.keys).to eq([:id, :type, :attributes])
      expect(recipe[:attributes].keys).to eq([:title, :url, :country, :image])
      expect(recipe[:id]).to be nil
      expect(recipe[:type]).to eq("recipe")
      expect(recipe[:attributes]).to be_a Hash
      expect(recipe[:attributes][:title]).to be_a(String)
      expect(recipe[:attributes][:url]).to be_a(String)
      expect(recipe[:attributes][:country]).to be_a(String)
      expect(recipe[:attributes][:image]).to be_a(String)
    end
  end

  it "returns random countries recipes when none is passed in", :vcr do
    json_response = File.read('spec/fixtures/random_country.json')
    stub_request(:get, "https://restcountries.com/v3.1/all").to_return(status: 200, body: json_response)

    get "/api/v1/recipes"

    recipes = JSON.parse(response.body, symbolize_names: true)[:data]
    recipes.each do |recipe|
      expect(recipe.keys).to eq([:id, :type, :attributes])
      expect(recipe[:attributes].keys).to eq([:title, :url, :country, :image])
      expect(recipe[:id]).to be nil
      expect(recipe[:type]).to eq("recipe")
      expect(recipe[:attributes]).to be_a Hash
      expect(recipe[:attributes][:title]).to be_a(String)
      expect(recipe[:attributes][:url]).to be_a(String)
      expect(recipe[:attributes][:country]).to be_a(String)
      expect(recipe[:attributes][:image]).to be_a(String)
    end
  end

  it "returns an empty array when passed in an empty string", :vcr do
    get "/api/v1/recipes?country="
    expect(response).to be_successful

    recipes = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(recipes).to be_an Array
    expect(recipes.count).to eq(0)
  end
end