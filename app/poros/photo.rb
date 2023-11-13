class Photo
  attr_reader :id, :alt_tag, :url

  def initialize(data)
    @alt_tag = data[:title]
    @url = "https://live.staticflickr.com/#{data[:server]}/#{data[:id]}_#{data[:secret]}_w.jpg"
  end
end