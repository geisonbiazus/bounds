defmodule Bounds.BoundingBoxBuilderTest do
  use ExUnit.Case, async: true

  setup do
    %{builder: Bounds.BoundingBoxBuilder.new()}
  end

  test "creates a BoundingBox adding two coordinates", %{builder: builder} do
    builder = Bounds.BoundingBoxBuilder.add_coord(builder, Bounds.Coordinate.new(1, 1))
    builder = Bounds.BoundingBoxBuilder.add_coord(builder, Bounds.Coordinate.new(2, 2))
    assert length(builder.list) == 1

    assert hd(builder.list) == Bounds.BoundingBox.new(1, 1, 2, 2)
  end

  test "creates multiple BoundingBoxes by continuously adding coordinates", %{builder: builder} do
    builder = Bounds.BoundingBoxBuilder.add_coord(builder, Bounds.Coordinate.new(1, 1))
    builder = Bounds.BoundingBoxBuilder.add_coord(builder, Bounds.Coordinate.new(2, 2))
    builder = Bounds.BoundingBoxBuilder.add_coord(builder, Bounds.Coordinate.new(3, 3))
    builder = Bounds.BoundingBoxBuilder.add_coord(builder, Bounds.Coordinate.new(4, 4))
    builder = Bounds.BoundingBoxBuilder.add_coord(builder, Bounds.Coordinate.new(5, 5))
    builder = Bounds.BoundingBoxBuilder.add_coord(builder, Bounds.Coordinate.new(6, 6))
    assert length(builder.list) == 3

    assert builder.list == [
             Bounds.BoundingBox.new(5, 5, 6, 6),
             Bounds.BoundingBox.new(3, 3, 4, 4),
             Bounds.BoundingBox.new(1, 1, 2, 2)
           ]
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

    bounding_boxes = Bounds.BoundingBoxBuilder.build_list(coordinates)

    assert bounding_boxes == [
             Bounds.BoundingBox.new(5, 5, 6, 6),
             Bounds.BoundingBox.new(3, 3, 4, 4),
             Bounds.BoundingBox.new(1, 1, 2, 2)
           ]
  end
end
