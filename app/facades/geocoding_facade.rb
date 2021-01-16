class GeocodingFacade
  def self.coordinates(params)
    coordinates = GeocodingService.get_coordinates(params)

    coord = {}
    coord[:lat] = coordinates[:results].first[:locations].first[:latLng][:lat]
    coord[:long] = coordinates[:results].first[:locations].first[:latLng][:lng]

    coord
  end
end
