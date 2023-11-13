class TouristSitesService

  def conn
    Faraday.new(url: "https://api.geoapify.com/v2/places") do |f|
      f.params[:categories] = "tourism.sights"
      f.params[:apiKey] = Rails.application.credentials.geoapify[:key]
    end
  end

  def get_url(url)
    response = conn.get(url)
    json = JSON.parse(response.body, symbolize_names: true)
  end

  def sites(latlng)
    get_url("?filter=circle:#{latlng[1]},#{latlng[0]},1000")
  end
end