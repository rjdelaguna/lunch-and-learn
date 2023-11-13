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
  end
end