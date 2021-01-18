class PhotoFacade
  def self.photo(params, weather)
    photo_info = PhotoService.get_photo(params, weather)

    if photo_info[:total] != 0
      Photo.new(photo_info, params)
    else
      return { error: 'Please provide a valid city for the search.', status: 400 }
    end
  end
end
