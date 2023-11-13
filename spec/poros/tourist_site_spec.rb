require "rails_helper"

RSpec.describe TouristSite do
  before :each do
    attrs = {
      properties: {
        name: "Chapelle expiatoire",
        formatted: "Chapelle expiatoire, Rue d'Anjou, 75008 Paris, France",
        place_id: "51be3fa49003950240597e41ec5ad56f4840f00102f901b5d706040000000092031343686170656c6c65206578706961746f697265"
      }
    }
    @site = TouristSite.new(attrs)
  end
  
  it "exists" do

    expect(@site).to be_a TouristSite
  end

  it "has readable attributes" do
    
    expect(@site.id).to be nil
    expect(@site.name).to eq("Chapelle expiatoire")
    expect(@site.address).to eq("Chapelle expiatoire, Rue d'Anjou, 75008 Paris, France")
    expect(@site.place_id).to eq("51be3fa49003950240597e41ec5ad56f4840f00102f901b5d706040000000092031343686170656c6c65206578706961746f697265")
  end
  
  it "returns string of 'none' if no address exists" do
    attrs = {
      properties: {
        name: "Chapelle expiatoire",
        place_id: "51be3fa49003950240597e41ec5ad56f4840f00102f901b5d706040000000092031343686170656c6c65206578706961746f697265"
      }
    }
    site1 = TouristSite.new(attrs)
    
    expect(site1.id).to be nil
    expect(site1.name).to eq("Chapelle expiatoire")
    expect(site1.address).to eq("none")
    expect(site1.place_id).to eq("51be3fa49003950240597e41ec5ad56f4840f00102f901b5d706040000000092031343686170656c6c65206578706961746f697265")
  end
end