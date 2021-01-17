class PhotoFacade
  def self.photo(params)
    photo_info = PhotoService.get_photo(params)

    Photo.new(photo_info, params)
  end
end
