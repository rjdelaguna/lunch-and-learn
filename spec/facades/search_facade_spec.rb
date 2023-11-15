require "rails_helper"

RSpec.describe SearchFacade do
  before :each do
    @sf = SearchFacade.new
  end

  it "exists" do
    expect(@sf).to be_a SearchFacade
  end

  describe "instance_methods" do
    it "#countries", :vcr do
      selected = @sf.countries

      expect(selected).to be_a String
    end

    it "#recipes", :vcr do
      recipes = @sf.recipes("germany")
      expect(recipes).to be_an Array
      expect(recipes).to all be_a Recipe
      recipes.each do |r|
        expect(r.instance_variables).to eq([:@title, :@url, :@country, :@image])
      end
    end
    
    it "if no recipes are found it returns an empty array", :vcr do
      recipes = @sf.recipes("asldfjalshasfgsf")
      expect(recipes).to be_an Array
      expect(recipes.count).to eq(0)
    end

    it "#video", :vcr do
      video = @sf.video("germany")
      expect(video).to be_a Video
      expect(video.instance_variables).to eq([:@title, :@youtube_video_id])
      expect(video.title).to be_a String
      expect(video.youtube_video_id).to be_a String
    end

    it "if no video is found it returns an empty hash", :vcr do
      video = @sf.video("asldfjalshasfgsf")
      expect(video).to be_a Hash
      expect(video.keys).to eq([])
    end
    
    it "if nothing is passed in it returns an empty hash", :vcr do
      video = @sf.video(nil)
      expect(video).to be_a Hash
      expect(video.keys).to eq([])
    end
    
    it "if an empty string is passed in it returns an empty hash", :vcr do
      video = @sf.video("")
      expect(video).to be_a Hash
      expect(video.keys).to eq([])
    end
    
    it "#photos", :vcr do
      photos = @sf.photos("germany")
      expect(photos).to be_an Array
      expect(photos).to all be_a Photo
      photos.each do |p|
        expect(p.instance_variables).to eq([:@alt_tag, :@url])
        expect(p.alt_tag).to be_a String
        expect(p.url).to be_a String
      end
    end

    it "if no photos is found it returns an empty array", :vcr do
      photos = @sf.photos("asldfjalshasfgsf")
      expect(photos).to be_an Array
      expect(photos.count).to eq(0)
    end
    
    it "if no country is passed it returns an empty array", :vcr do
      photos = @sf.photos(nil)
      expect(photos).to be_an Array
      expect(photos.count).to eq(0)
    end
    
    it "#tourist_sites", :vcr do
      tourist_sites = @sf.tourist_sites("New Zealand")
      expect(tourist_sites).to be_an Array
      expect(tourist_sites).to all be_a TouristSite
      tourist_sites.each do |p|
        expect(p.instance_variables).to eq([:@name, :@address, :@place_id])
        expect(p.name).to be_a String
        expect(p.address).to be_a String
        expect(p.place_id).to be_a String
      end
    end

    it "if no tourist_sites are found it returns an empty array", :vcr do
      tourist_sites = @sf.tourist_sites("Uruguay")
      expect(tourist_sites).to be_an Array
      expect(tourist_sites.count).to eq(0)
    end
    
    it "if no country was found it returns 'Country Not Found'", :vcr do
      tourist_sites = @sf.tourist_sites("asifubg")
      expect(tourist_sites).to be_a String
      expect(tourist_sites).to eq("Country Not Found")
    end
    
    it "if no country was passed in it returns 'Country Not Found'", :vcr do
      tourist_sites = @sf.tourist_sites(nil)
      expect(tourist_sites).to be_a String
      expect(tourist_sites).to eq("Country Not Found")
    end
  end
end