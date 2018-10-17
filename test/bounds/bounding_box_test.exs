defmodule Bounds.BoundingBoxTest do
  use ExUnit.Case

  test "creates a new bounding box" do
    coord_a = %Bounds.Coordinate{lon: 0, lat: 1}
    coord_b = %Bounds.Coordinate{lon: 2, lat: 3}
    box = Bounds.BoundingBox.create(coord_a, coord_b)

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
    box = Bounds.BoundingBox.create(coord_a, coord_b)

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
    box = Bounds.BoundingBox.create(coord_a, coord_b)

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
end
