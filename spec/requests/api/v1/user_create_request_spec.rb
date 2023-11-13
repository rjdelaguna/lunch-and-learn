require "rails_helper"

describe "Create a new user request" do
  it "creates a new iser when all information is good" do
    user = {
      "name": "Odell",
      "email": "goodboy@ruffruff.com",
      "password": "treats4lyf",
      "password_confirmation": "treats5lyf"
    }
    post "/api/v1/users", params: user, as: :json

  end
end