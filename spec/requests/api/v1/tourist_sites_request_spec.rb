require "rails_helper"

describe "Tourist sites request" do
  it "accepts query param of country name", :vcr do
    get "/api/v1/tourist_sites?country=France"

    expect(response).to be_successful

    resources = JSON.parse(response.body, symbolize_names: true)[:data]
    
    expect(resources.keys).to eq([:id, :type, :attributes])
    expect(resources[:attributes].keys).to eq([:name, :address, :place_id])
    expect(resources[:id]).to be nil
    expect(resources[:type]).to eq("tourist_site")
    expect(resources[:attributes]).to be_a Hash
    expect(resources[:attributes][:name]).to be_a String
    expect(resources[:attributes][:address]).to be_a String
    expect(resources[:attributes][:place_id]).to be_a String
  end
end