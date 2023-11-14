require "rails_helper"

RSpec.describe Video do
  before :each do
    attrs = {
      snippet: { title: "Informational Video" },
      id: {videoId: "123456789" }
      }
    @video = Video.new(attrs)
  end
  
  it "exists" do

    expect(@video).to be_a Video
  end

  it "has readable attributes" do
    
    expect(@video.id).to be nil
    expect(@video.title).to eq("Informational Video")
    expect(@video.youtube_video_id).to eq("123456789")
  end
end