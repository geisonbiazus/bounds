defmodule Bounds.Services.GetOriginAndDestinationBoundingBoxesService do
  alias Bounds.Entities.{Coordinate, BoundingBoxRepository, BoundingBox}

  def run(repository, {origin_lon, origin_lat}, {destination_lon, destination_lat}) do
    origin = Coordinate.new(origin_lon, origin_lat)
    destination = Coordinate.new(destination_lon, destination_lat)
    result = produce_result(repository, origin, destination)

    {store_bounding_box(repository, origin, destination), result}
  end

  defp produce_result(repository, origin, destination) do
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

  defp store_bounding_box(repository, origin, destination) do
    BoundingBoxRepository.add(repository, BoundingBox.new(origin, destination))
  end
end
