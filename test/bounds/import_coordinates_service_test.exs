defmodule Bounds.ImportCoordinatesServiceTest do
  use ExUnit.Case, async: true

  test "generates bounding boxes assigning the coordinates from the given files" do
    pairs_path = "#{__DIR__}/files/pairs.csv"
    coordinates_path = "#{__DIR__}/files/coordinates.csv"
    result = Bounds.ImportCoordinatesService.run(pairs_path, coordinates_path)

    assert result == [
             %{
               coordinate: Bounds.Coordinate.new(2.1, 2.9),
               bounding_box: Bounds.BoundingBox.new(1.3, 2.3, 2.5, 5.3)
             },
             %{
               coordinate: Bounds.Coordinate.new(7.0, 7.0),
               bounding_box: Bounds.BoundingBox.new(1.0, 3.0, 9.0, 8.0)
             }
           ]
  end
end
