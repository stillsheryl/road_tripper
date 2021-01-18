class DirectionsFacade
  def self.directions_time(params)
    times = DirectionsService.get_directions(params)

    if times[:error]
      times[:error]
    else
      [times[:route][:realTime], times[:route][:formattedTime][0..4]]
    end
  end
end
