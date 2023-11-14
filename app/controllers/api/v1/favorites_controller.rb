class Api::V1::FavoritesController < ApplicationController
  def index
    user = User.find_by(api_key: params[:api_key])
    if !user
      render json: ErrorSerializer.new(ErrorMessage.new("User Not Found", "404")), status: :not_found
    else
      render json: FavoriteSerializer.new(user.favorites)
    end
  end

  def create
    # 70961c8c9d9e7638f21a454d25acd525
    user = User.find_by(api_key: params[:api_key])
    if !user
      render json: ErrorSerializer.new(ErrorMessage.new("User Not Found", "404")), status: :not_found
    else
      favorite = user.favorites.create(favorite_params)
      render json: { success: "Favorite added successfully"}, status: 201
    end
  end

  private

  def favorite_params
    params.permit(:country, :recipe_link, :recipe_title)
  end
end