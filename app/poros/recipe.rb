class Recipe
    attr_reader :id, :title, :url, :country, :image

  def initialize( country, data)
    @title = data[:recipe][:label]
    @url = data[:recipe][:url]
    @country = country
    @image = data[:recipe][:image]
  end
end