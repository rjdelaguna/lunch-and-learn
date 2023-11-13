require "rails_helper"

describe "Tourist sites request" do
  it "accepts query param of country name", :vcr do
    get "/api/v1/tourist_sites?country=France"

    expect(response).to be_successful

    sites = JSON.parse(response.body, symbolize_names: true)[:data]
    
    expect(sites).to be_an Array
    sites.each do |site|
    expect(site.keys).to eq([:id, :type, :attributes])
    expect(site[:attributes].keys).to eq([:name, :address, :place_id])
    expect(site[:id]).to be nil
    expect(site[:type]).to eq("tourist_site")
    expect(site[:attributes]).to be_a Hash
    expect(site[:attributes][:name]).to be_a String
    expect(site[:attributes][:address]).to be_a String
    expect(site[:attributes][:place_id]).to be_a String
    end
  end
  
  it "returns empty array when no results are returned", :vcr do
    get "/api/v1/tourist_sites?country=Uruguay"

    expect(response).to be_successful

    sites = JSON.parse(response.body, symbolize_names: true)[:data]
    
    expect(sites).to be_an Array
    expect(sites.count).to eq(0)
  end
end