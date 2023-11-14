require "rails_helper"

RSpec.describe LearningResource do
  before :each do
    video = "video.url"
    images = ["image link 1", "image link 2"]
    @lr = LearningResource.new("thailand", video, images)
  end
  
  it "exists" do

    expect(@lr).to be_a LearningResource
  end

  it "has readable attributes" do
    
    expect(@lr.id).to be nil
    expect(@lr.country).to eq("thailand")
    expect(@lr.video).to eq("video.url")
    expect(@lr.images).to eq(["image link 1", "image link 2"])
  end
end