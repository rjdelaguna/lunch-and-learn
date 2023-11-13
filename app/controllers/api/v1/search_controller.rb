class Api::V1::SearchController < ApplicationController
  def recipes 
    if !params[:country]
      country = SearchFacade.new.countries
    else
      country = params[:country]
    end

    render json: RecipeSerializer.new(SearchFacade.new.recipes(country))
  end

  def learning_resources
    country = params[:country]
    render json: LearningResourceSerializer.new(LearningResource.new(country, SearchFacade.new.video(country), SearchFacade.new.photos(country)))
  end
end