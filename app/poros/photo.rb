class Photo
  attr_reader :image, :id
  def initialize(photo_info, params)
    @image = image_info(photo_info[:results].first, params)
    @id = nil
  end

  def image_info(photo_info, params)
    {
      location: params[:location],
      image_url: photo_info[:urls][:regular],
      credit: {
        photographer_name: photo_info[:user][:name],
        photographer_profile_link: "#{photo_info[:user][:links][:html]}?utm_source=road_tripper&utm_medium=referral",
        source_link: "https://unsplash.com/?utm_source=road_tripper&utm_medium=referral"
      }
    }
  end
end
