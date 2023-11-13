class SearchFacade

  def countries
    RestCountriesService.new.countries.sample[:name][:common]
  end

  def recipes(index)
    RecipesService.new.recipes(index)[:hits].map do |r|
      Recipe.new(index, r)
    end
  end

  def video(index)
    video = VideoService.new.video(index)[:items].first
    if !index || index == "" || !video
      {}
    else
      Video.new(video)
    end
  end

  def photos(index)
    photos = PhotoService.new.photo(index)
    if photos[:stat] != "ok"
      []
    else
      photos[:photos][:photo].sample(10).map do |p|
        Photo.new(p)
      end
    end
  end

  def places(index)
    places = PlacesService.new.places(index)
  end
end