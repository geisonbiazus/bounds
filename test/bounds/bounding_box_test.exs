defmodule Bounds.BoundingBoxTest do
  use ExUnit.Case, async: true

  test "creates a new bounding box" do
    coord_a = %Bounds.Coordinate{lon: 0, lat: 1}
    coord_b = %Bounds.Coordinate{lon: 2, lat: 3}
    box = Bounds.BoundingBox.new(coord_a, coord_b)

    assert box == %Bounds.BoundingBox{
             southwest: %Bounds.Coordinate{
               lon: 0,
               lat: 1
             },
             northeast: %Bounds.Coordinate{
               lon: 2,
               lat: 3
             }
           }
  end

  test "sets min and max points accordingly to the values" do
    coord_a = %Bounds.Coordinate{lon: 3, lat: 2}
    coord_b = %Bounds.Coordinate{lon: 1, lat: 0}
    box = Bounds.BoundingBox.new(coord_a, coord_b)

    assert box == %Bounds.BoundingBox{
             southwest: %Bounds.Coordinate{
               lon: 1,
               lat: 0
             },
             northeast: %Bounds.Coordinate{
               lon: 3,
               lat: 2
             }
           }
  end

  test "checks if a bounding_box contains a coordinate" do
    coord_a = %Bounds.Coordinate{lon: 1.5, lat: 1.5}
    coord_b = %Bounds.Coordinate{lon: 5.5, lat: 5.5}
    box = Bounds.BoundingBox.new(coord_a, coord_b)

    assert Bounds.BoundingBox.contains?(box, %Bounds.Coordinate{lon: 2, lat: 2})
    assert Bounds.BoundingBox.contains?(box, %Bounds.Coordinate{lon: 1.5, lat: 1.5})
    assert Bounds.BoundingBox.contains?(box, %Bounds.Coordinate{lon: 5.5, lat: 5.5})
    assert not Bounds.BoundingBox.contains?(box, %Bounds.Coordinate{lon: 0, lat: 0})
    assert not Bounds.BoundingBox.contains?(box, %Bounds.Coordinate{lon: 1.4, lat: 1.5})
    assert not Bounds.BoundingBox.contains?(box, %Bounds.Coordinate{lon: 0, lat: 2})
    assert not Bounds.BoundingBox.contains?(box, %Bounds.Coordinate{lon: 6, lat: 2})
    assert not Bounds.BoundingBox.contains?(box, %Bounds.Coordinate{lon: 2, lat: 0})
    assert not Bounds.BoundingBox.contains?(box, %Bounds.Coordinate{lon: 2, lat: 6})
  end

  test "builds a bounding box list from a coordinates list" do
    coordinates = [
      Bounds.Coordinate.new(1, 1),
      Bounds.Coordinate.new(2, 2),
      Bounds.Coordinate.new(3, 3),
      Bounds.Coordinate.new(4, 4),
      Bounds.Coordinate.new(5, 5),
      Bounds.Coordinate.new(6, 6)
    ]

    bounding_boxes = Enum.to_list(Bounds.BoundingBox.build_list(coordinates))

    assert bounding_boxes == [
             Bounds.BoundingBox.new(1, 1, 2, 2),
             Bounds.BoundingBox.new(3, 3, 4, 4),
             Bounds.BoundingBox.new(5, 5, 6, 6)
           ]
  end

  test "ignores odd values" do
    coordinates = [
      Bounds.Coordinate.new(1, 1),
      Bounds.Coordinate.new(2, 2),
      Bounds.Coordinate.new(3, 3)
    ]

    bounding_boxes = Enum.to_list(Bounds.BoundingBox.build_list(coordinates))

    assert bounding_boxes == [
             Bounds.BoundingBox.new(1, 1, 2, 2)
           ]
  end
end
