class PlacesService

  def conn
    Faraday.new(url: "https://api.geoapify.com/v2/places") do |f|
      f.params[:categories] = "catering."
      f.params[:limit] = 20
      f.params[:apiKey] = Rails.application.credentials.geoapify[:key]
    end
  end

  def get_url(url)
    response = conn.get(url)
    json = JSON.parse(response.body, symbolize_names: true)
  end

  def places(index)
    get_url("?filter=circle:#{index[:lat]},#{index[:lon]},5000")
  end
end