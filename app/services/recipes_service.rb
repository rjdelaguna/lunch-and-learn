class RecipesService

  def conn
    Faraday.new(url: "https://api.edamam.com/api/recipes/v2") do |f|
      f.params["app_id"] = Rails.application.credentials.edamam[:id]
      f.params["app_key"] = Rails.application.credentials.edamam[:key]
    end
  end

  def get_url(url)
    response = conn.get(url)
    json = JSON.parse(response.body, symbolize_names: true)
  end

  def recipes(index)
    get_url("?type=public&q=#{index}")
  end
end