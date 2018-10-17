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
end
