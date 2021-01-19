class DirectionsFacade
  def self.directions_time(params)
    times = DirectionsService.get_directions(params)

    if times[:error]
      times[:error]
    else
      [times[:route][:realTime], times[:route][:formattedTime][0..4]]
    end
  end

  def self.directions_time_start_end(params)
    times = DirectionsService.get_directions_start_end(params)

    if times[:error]
      times[:error]
    else
      [times[:route][:realTime], times[:route][:formattedTime][0..4]]
    end
  end
end
