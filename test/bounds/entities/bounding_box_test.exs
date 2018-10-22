defmodule Bounds.BoundingBoxTest do
  use ExUnit.Case, async: true

  alias Bounds.Entities.{BoundingBox, Coordinate}

  test "creates a new bounding box" do
    coord_a = %Coordinate{lon: 0, lat: 1}
    coord_b = %Coordinate{lon: 2, lat: 3}
    box = BoundingBox.new(coord_a, coord_b)

    assert box == %BoundingBox{
             southwest: %Coordinate{
               lon: 0,
               lat: 1
             },
             northeast: %Coordinate{
               lon: 2,
               lat: 3
             }
           }
  end

  test "sets min and max points accordingly to the values" do
    coord_a = %Coordinate{lon: 3, lat: 2}
    coord_b = %Coordinate{lon: 1, lat: 0}
    box = BoundingBox.new(coord_a, coord_b)

    assert box == %BoundingBox{
             southwest: %Coordinate{
               lon: 1,
               lat: 0
             },
             northeast: %Coordinate{
               lon: 3,
               lat: 2
             }
           }
  end

  test "checks if a bounding_box contains a coordinate" do
    coord_a = %Coordinate{lon: 1.5, lat: 1.5}
    coord_b = %Coordinate{lon: 5.5, lat: 5.5}
    box = BoundingBox.new(coord_a, coord_b)

    assert BoundingBox.contains?(box, %Coordinate{lon: 2, lat: 2})
    assert BoundingBox.contains?(box, %Coordinate{lon: 1.5, lat: 1.5})
    assert BoundingBox.contains?(box, %Coordinate{lon: 5.5, lat: 5.5})
    assert not BoundingBox.contains?(box, %Coordinate{lon: 0, lat: 0})
    assert not BoundingBox.contains?(box, %Coordinate{lon: 1.4, lat: 1.5})
    assert not BoundingBox.contains?(box, %Coordinate{lon: 0, lat: 2})
    assert not BoundingBox.contains?(box, %Coordinate{lon: 6, lat: 2})
    assert not BoundingBox.contains?(box, %Coordinate{lon: 2, lat: 0})
    assert not BoundingBox.contains?(box, %Coordinate{lon: 2, lat: 6})
  end

  test "builds a bounding box list from a coordinates list" do
    coordinates = [
      Coordinate.new(1, 1),
      Coordinate.new(2, 2),
      Coordinate.new(3, 3),
      Coordinate.new(4, 4),
      Coordinate.new(5, 5),
      Coordinate.new(6, 6)
    ]

    bounding_boxes = Enum.to_list(BoundingBox.build_list(coordinates))

    assert bounding_boxes == [
             BoundingBox.new(1, 1, 2, 2),
             BoundingBox.new(3, 3, 4, 4),
             BoundingBox.new(5, 5, 6, 6)
           ]
  end

  test "ignores odd values" do
    coordinates = [
      Coordinate.new(1, 1),
      Coordinate.new(2, 2),
      Coordinate.new(3, 3)
    ]

    bounding_boxes = Enum.to_list(BoundingBox.build_list(coordinates))

    assert bounding_boxes == [
             BoundingBox.new(1, 1, 2, 2)
           ]
  end
end
