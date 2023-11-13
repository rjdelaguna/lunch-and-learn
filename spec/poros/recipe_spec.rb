require "rails_helper"

RSpec.describe Recipe do
  before :each do
    attrs = {
      recipe: {
        label: "This Recipe",
        url: "website.com",
        image: "image link"
      }
    }
    @recipe = Recipe.new("thailand", attrs)
  end
  
  it "exists" do

    expect(@recipe).to be_a Recipe
  end

  it "has readable attributes" do
    
    expect(@recipe.id).to be nil
    expect(@recipe.title).to eq("This Recipe")
    expect(@recipe.url).to eq("website.com")
    expect(@recipe.country).to eq("thailand")
    expect(@recipe.image).to eq("image link")
  end
end