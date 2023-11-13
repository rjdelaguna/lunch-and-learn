class PhotoService

  def conn
    Faraday.new(url: "https://www.flickr.com/services/rest/") do |f|
      f.params[:method] = "flickr.photos.search"
      f.params[:format] = "json"
      f.params[:api_key] = Rails.application.credentials.flickr[:key]
    end
  end

  def get_url(url)
    response = conn.get(url)
    json = JSON.parse(response.body[14..-2], symbolize_names: true)
  end

  def photo(index)
    get_url("?tags=#{index}")
  end
end