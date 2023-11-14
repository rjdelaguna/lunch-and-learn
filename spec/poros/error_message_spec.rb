require "rails_helper"

RSpec.describe ErrorMessage do
  before :each do
    @error_message = ErrorMessage.new("Error Message", "400")
  end
  
  it "exists" do
    expect(@error_message).to be_a ErrorMessage
  end

  it "has readable attributes" do
    expect(@error_message.id).to be nil
    expect(@error_message.message).to eq("Error Message")
    expect(@error_message.status_code).to eq("400")
  end
end