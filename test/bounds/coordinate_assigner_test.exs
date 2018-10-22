defmodule Bounds.CoordinateAssignerTest do
  use ExUnit.Case, async: true

  alias Bounds.{BoundingBox, Coordinate, CoordinateAssigner}

  test "assigns the coordinates that are inside the bounding boxes" do
    bounding_boxes = [
      BoundingBox.new(10, 10, 15, 15),
      BoundingBox.new(20, 20, 25, 25)
    ]

    coodinates = [
      Coordinate.new(11, 11),
      Coordinate.new(12, 12),
      Coordinate.new(22, 22)
    ]

    result = CoordinateAssigner.assign(bounding_boxes, coodinates)

    assert result == [
             %{
               coordinate: Coordinate.new(11, 11),
               bounding_box: BoundingBox.new(10, 10, 15, 15)
             },
             %{
               coordinate: Coordinate.new(12, 12),
               bounding_box: BoundingBox.new(10, 10, 15, 15)
             },
             %{
               coordinate: Coordinate.new(22, 22),
               bounding_box: BoundingBox.new(20, 20, 25, 25)
             }
           ]
  end

  test "assigns each coordinate to only one bounding box" do
    bounding_boxes = [
      BoundingBox.new(1, 1, 5, 5),
      BoundingBox.new(2, 2, 6, 6)
    ]

    coodinates = [
      Coordinate.new(3, 3),
      Coordinate.new(6, 6)
    ]

    result = CoordinateAssigner.assign(bounding_boxes, coodinates)

    assert result == [
             %{
               coordinate: Coordinate.new(3, 3),
               bounding_box: BoundingBox.new(1, 1, 5, 5)
             },
             %{
               coordinate: Coordinate.new(6, 6),
               bounding_box: BoundingBox.new(2, 2, 6, 6)
             }
           ]
  end

  test "ignores coordinates and bounding boxes that doesn't match" do
    bounding_boxes = [
      BoundingBox.new(1, 1, 5, 5),
      BoundingBox.new(2, 2, 6, 6)
    ]

    coodinates = [
      Coordinate.new(1, 1),
      Coordinate.new(9, 9)
    ]

    result = CoordinateAssigner.assign(bounding_boxes, coodinates)

    assert result == [
             %{
               coordinate: Coordinate.new(1, 1),
               bounding_box: BoundingBox.new(1, 1, 5, 5)
             }
           ]
  end
end
