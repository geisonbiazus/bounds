defmodule Bounds.BoundingBoxList do
  defstruct bounding_boxes: [], last_coord: nil

  def new do
    %Bounds.BoundingBoxList{}
  end

  def add_coord(list, coord) do
    if list.last_coord == nil do
      %Bounds.BoundingBoxList{
        bounding_boxes: list.bounding_boxes,
        last_coord: coord
      }
    else
      %Bounds.BoundingBoxList{
        bounding_boxes: [Bounds.BoundingBox.create(list.last_coord, coord) | list.bounding_boxes]
      }
    end
  end
end
