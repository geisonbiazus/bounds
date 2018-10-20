defmodule Bounds.CoordinateAssigner do
  def assign(bounding_boxes, coordinates) do
    bounding_boxes
    |> Enum.map_reduce(coordinates, fn box, coordinates ->
      {found, remaining} = filter_coordinates(box, coordinates)
      {%{bounding_box: box, coordinates: found}, remaining}
    end)
    |> elem(0)
  end

  defp filter_coordinates(box, coordinates) do
    Enum.split_with(coordinates, &Bounds.BoundingBox.contains?(box, &1))
  end
end
