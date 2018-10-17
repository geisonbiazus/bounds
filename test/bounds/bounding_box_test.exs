defmodule Bounds.BoundingBoxTest do
  use ExUnit.Case

  test "creates a new bounding box" do
    box = Bounds.BoundingBox.create(0, 1, 2, 3)

    assert box == %Bounds.BoundingBox{
             min_lon: 0,
             min_lat: 1,
             max_lon: 2,
             max_lat: 3
           }
  end

  test "sets min and max points accordingly to the values" do
    box = Bounds.BoundingBox.create(3, 2, 1, 0)

    assert box == %Bounds.BoundingBox{
             min_lon: 1,
             min_lat: 0,
             max_lon: 3,
             max_lat: 2
           }
  end
end
