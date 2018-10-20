defmodule Bounds.CoordinateAssignerTest do
  use ExUnit.Case, async: true

  test "assigns the coordinates that are inside the bounding boxes " do
    bounding_boxes = [
      Bounds.BoundingBox.new(1, 1, 5, 5),
      Bounds.BoundingBox.new(10, 10, 15, 15),
      Bounds.BoundingBox.new(20, 20, 25, 25)
    ]

    coodinates = [
      Bounds.Coordinate.new(11, 11),
      Bounds.Coordinate.new(12, 12),
      Bounds.Coordinate.new(22, 22)
    ]

    result = Bounds.CoordinateAssigner.assign(bounding_boxes, coodinates)

    assert result == [
             %{
               bounding_box: Bounds.BoundingBox.new(1, 1, 5, 5),
               coordinates: []
             },
             %{
               bounding_box: Bounds.BoundingBox.new(10, 10, 15, 15),
               coordinates: [Bounds.Coordinate.new(11, 11), Bounds.Coordinate.new(12, 12)]
             },
             %{
               bounding_box: Bounds.BoundingBox.new(20, 20, 25, 25),
               coordinates: [Bounds.Coordinate.new(22, 22)]
             }
           ]
  end

  test "assigns each coordinate to only one bounding box" do
    bounding_boxes = [
      Bounds.BoundingBox.new(1, 1, 5, 5),
      Bounds.BoundingBox.new(2, 2, 6, 6)
    ]

    coodinates = [
      Bounds.Coordinate.new(3, 3)
    ]

    result = Bounds.CoordinateAssigner.assign(bounding_boxes, coodinates)

    assert result == [
             %{
               bounding_box: Bounds.BoundingBox.new(1, 1, 5, 5),
               coordinates: [Bounds.Coordinate.new(3, 3)]
             },
             %{
               bounding_box: Bounds.BoundingBox.new(2, 2, 6, 6),
               coordinates: []
             }
           ]
  end
end
