class RestaurantFacade
  def self.get_restaurant(params, time)
    restaurants = RestaurantsService.get_restaurants(params, time)

    Restaurant.new(restaurants[:businesses].first)
  end
end
