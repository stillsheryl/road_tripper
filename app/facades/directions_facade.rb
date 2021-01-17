class DirectionsFacade
  def self.directions_time(params)
    times = DirectionsService.get_directions(params)

    [times[:route][:realTime], times[:route][:formattedTime][0..4]]
  end
end
