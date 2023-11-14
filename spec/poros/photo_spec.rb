require "rails_helper"

RSpec.describe Photo do
  before :each do
    attrs = {
      title: "Picture of things",
      server: "1234",
      id: "5678",
      secret: "9012"
    }
    @photo = Photo.new(attrs)
  end
  
  it "exists" do
    expect(@photo).to be_a Photo
  end

  it "has readable attributes" do
    expect(@photo.id).to be nil
    expect(@photo.alt_tag).to eq("Picture of things")
    expect(@photo.url).to eq("https://live.staticflickr.com/1234/5678_9012_w.jpg")
  end
end