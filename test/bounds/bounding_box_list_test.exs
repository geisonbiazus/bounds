defmodule Bounds.BoundingBoxListTest do
  use ExUnit.Case, async: true

  setup do
    %{list: Bounds.BoundingBoxList.new()}
  end

  test "creates a BoundingBox adding two coordinates", %{list: list} do
    list = Bounds.BoundingBoxList.add_coord(list, Bounds.Coordinate.new(1, 1))
    list = Bounds.BoundingBoxList.add_coord(list, Bounds.Coordinate.new(2, 2))
    assert length(list.bounding_boxes) == 1

    assert hd(list.bounding_boxes) == Bounds.BoundingBox.new(1, 1, 2, 2)
  end

  test "creates multiple BoundingBox by continuously adding coordinates", %{list: list} do
    list = Bounds.BoundingBoxList.add_coord(list, Bounds.Coordinate.new(1, 1))
    list = Bounds.BoundingBoxList.add_coord(list, Bounds.Coordinate.new(2, 2))
    list = Bounds.BoundingBoxList.add_coord(list, Bounds.Coordinate.new(3, 3))
    list = Bounds.BoundingBoxList.add_coord(list, Bounds.Coordinate.new(4, 4))
    list = Bounds.BoundingBoxList.add_coord(list, Bounds.Coordinate.new(5, 5))
    list = Bounds.BoundingBoxList.add_coord(list, Bounds.Coordinate.new(6, 6))
    assert length(list.bounding_boxes) == 3

    assert list.bounding_boxes == [
             Bounds.BoundingBox.new(5, 5, 6, 6),
             Bounds.BoundingBox.new(3, 3, 4, 4),
             Bounds.BoundingBox.new(1, 1, 2, 2)
           ]
  end
end
