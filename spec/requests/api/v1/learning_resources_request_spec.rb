require "rails_helper"

describe "Learning Resources request" do
  it "accepts query param of country name", :vcr do
    get "/api/v1/learning_resources?country=thailand"

    expect(response).to be_successful

    resources = JSON.parse(response.body, symbolize_names: true)[:data]
    
    expect(resources.keys).to eq([:id, :type, :attributes])
    expect(resources[:attributes].keys).to eq([:country, :video, :images])
    expect(resources[:id]).to be nil
    expect(resources[:type]).to eq("learning_resource")
    expect(resources[:attributes]).to be_a Hash
    expect(resources[:attributes][:country]).to be_a String
    expect(resources[:attributes][:video]).to be_a Hash
    expect(resources[:attributes][:video].keys).to eq([:title, :youtube_video_id])
    expect(resources[:attributes][:video][:title]).to be_a String
    expect(resources[:attributes][:video][:youtube_video_id]).to be_a String
    expect(resources[:attributes][:images]).to be_an Array
    expect(resources[:attributes][:images]).to all be_a Hash
    resources[:attributes][:images].each do |image|
      expect(image.keys).to eq([:alt_tag, :url])
      expect(image[:alt_tag]).to be_a String
      expect(image[:url]).to be_a String
    end
  end

  it "returns a hash with empty attributes when not passed a country param", :vcr do
    get "/api/v1/learning_resources?"
    expect(response).to be_successful

    resources = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(resources).to be_a Hash
    expect(resources.keys).to eq([:id, :type, :attributes])
    expect(resources[:id]).to be nil
    expect(resources[:type]).to eq("learning_resource")
    expect(resources[:attributes]).to be_a Hash
    expect(resources[:attributes].keys).to eq([:country, :video, :images])
    expect(resources[:attributes][:country]).to be nil
    expect(resources[:attributes][:video]).to be_a Hash
    expect(resources[:attributes][:video].keys).to eq([])
    expect(resources[:attributes][:images]).to be_an Array
    expect(resources[:attributes][:images].count).to eq(0)
  end
  
  it "returns a hash with empty attributes when passed in an empty string", :vcr do
    get "/api/v1/learning_resources?country="
    expect(response).to be_successful

    resources = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(resources).to be_a Hash
    expect(resources.keys).to eq([:id, :type, :attributes])
    expect(resources[:id]).to be nil
    expect(resources[:type]).to eq("learning_resource")
    expect(resources[:attributes]).to be_a Hash
    expect(resources[:attributes].keys).to eq([:country, :video, :images])
    expect(resources[:attributes][:country]).to eq("")
    expect(resources[:attributes][:video]).to be_a Hash
    expect(resources[:attributes][:video].keys).to eq([])
    expect(resources[:attributes][:images]).to be_an Array
    expect(resources[:attributes][:images].count).to eq(0)
  end
end