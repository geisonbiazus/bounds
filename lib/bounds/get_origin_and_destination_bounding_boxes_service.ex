defmodule Bounds.GetOriginAndDestinationBoundingBoxesService do
  alias Bounds.{Coordinate, BoundingBoxRepository}

  def run(repository, {origin_lon, origin_lat}, {destination_lon, destination_lat}) do
    origin = Coordinate.new(origin_lon, origin_lat)
    destination = Coordinate.new(destination_lon, destination_lat)

    [
      matching_bounding_boxes(repository, origin),
      matching_bounding_boxes(repository, destination)
    ]
  end

  defp matching_bounding_boxes(repository, coordinate) do
    %{
      coordinate: coordinate,
      bounding_boxes: BoundingBoxRepository.find_all_containing(repository, coordinate)
    }
  end
end
