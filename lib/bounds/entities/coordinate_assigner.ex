defmodule Bounds.Entities.CoordinateAssigner do
  alias Bounds.Entities.BoundingBox

  def assign(bounding_boxes, coordinates) do
    coordinates
    |> Stream.map(&assign_coordinate(&1, bounding_boxes))
    |> Stream.reject(&no_bounding_box?(&1))
    |> Enum.to_list()
  end

  defp assign_coordinate(coordinate, bounding_boxes) do
    %{
      coordinate: coordinate,
      bounding_box: Enum.find(bounding_boxes, &BoundingBox.contains?(&1, coordinate))
    }
  end

  defp no_bounding_box?(%{bounding_box: nil}), do: true
  defp no_bounding_box?(_), do: false
end
