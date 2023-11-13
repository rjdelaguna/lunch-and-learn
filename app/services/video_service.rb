class VideoService

  def conn
    Faraday.new(url: "https://www.googleapis.com/youtube/v3/search") do |f|
      f.params["part"] = "snippet"
      f.params["channelId"] = "UCluQ5yInbeAkkeCndNnUhpw"
      f.params["key"] = Rails.application.credentials.youtube[:key]
    end
  end

  def get_url(url)
    response = conn.get(url)
    json = JSON.parse(response.body, symbolize_names: true)
  end

  def video(index)
    get_url("?q=#{index}")
  end
end