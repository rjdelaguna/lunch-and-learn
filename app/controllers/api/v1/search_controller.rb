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

  def tourist_sites
    country = params[:country]
    sites = SearchFacade.new.tourist_sites(country)
    if sites == "Country Not Found" || !country
      render json: ErrorSerializer.new(ErrorMessage.new("Country Not Found", "404")), status: :not_found
    else
      render json: TouristSiteSerializer.new(SearchFacade.new.tourist_sites(country))
    end
  end
end