class RestCountriesService

  def conn
    Faraday.new(url: "https://restcountries.com/v3.1/")
  end

  def get_url(url)
    response = conn.get(url)
    json = JSON.parse(response.body, symbolize_names: true)
  end

  def countries
    get_url("all")
  end

  def country(index)
    get_url("name/#{index}")
  end
end