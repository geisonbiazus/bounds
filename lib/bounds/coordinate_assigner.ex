defmodule Bounds.CoordinateAssigner do
  def assign(bounding_boxes, coordinates) do
    bounding_boxes
    |> Enum.map_reduce(coordinates, fn box, coordinates ->
      {found, remaining} = filter_coordinates(box, coordinates)
      {%{bounding_box: box, coordinates: found}, remaining}
    end)
    |> elem(0)
    |> Enum.reject(&empty_coordinates(&1))
  end

  defp filter_coordinates(box, coordinates) do
    Enum.split_with(coordinates, &Bounds.BoundingBox.contains?(box, &1))
  end

  defp empty_coordinates(%{coordinates: []}), do: true
  defp empty_coordinates(_), do: false
end
