defmodule Bounds.AssignCoordinatesTest do
  use ExUnit.Case, async: true

  alias Bounds.Entities.{BoundingBox, Coordinate, BoundingBoxRepository}
  alias Bounds.Services.AssignCoordinatesService

  setup do
    repository = BoundingBoxRepository.new()
    pairs_path = "#{__DIR__}/files/pairs.csv"
    coordinates_path = "#{__DIR__}/files/coordinates.csv"

    %{repository: repository, pairs_path: pairs_path, coordinates_path: coordinates_path}
  end

  test "generates bounding boxes assigning the coordinates from the given files", %{
    repository: repository,
    pairs_path: pairs_path,
    coordinates_path: coordinates_path
  } do
    {_, result} = AssignCoordinatesService.run(repository, pairs_path, coordinates_path)

    assert result == [
             %{
               coordinate: Coordinate.new(2.1, 2.9),
               bounding_box: BoundingBox.new(1.3, 2.3, 2.5, 5.3)
             },
             %{
               coordinate: Coordinate.new(7.0, 7.0),
               bounding_box: BoundingBox.new(1.0, 3.0, 9.0, 8.0)
             }
           ]
  end

  test "stores the bounding boxes in the repository", %{
    repository: repository,
    pairs_path: pairs_path,
    coordinates_path: coordinates_path
  } do
    {repository, _} = AssignCoordinatesService.run(repository, pairs_path, coordinates_path)

    assert BoundingBoxRepository.all(repository) == [
             BoundingBox.new(1.0, 3.0, 9.0, 8.0),
             BoundingBox.new(1.3, 2.3, 2.5, 5.3)
           ]
  end
end
