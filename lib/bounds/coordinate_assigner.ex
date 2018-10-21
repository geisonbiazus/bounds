defmodule Bounds.CoordinateAssigner do
  alias Bounds.BoundingBoxRepository

  def assign(repository, coordinates) do
    coordinates
    |> Stream.map(&assign_coordinate(&1, repository))
    |> Stream.reject(&no_bounding_box?(&1))
    |> Enum.to_list()
  end

  defp assign_coordinate(coordinate, repository) do
    %{
      coordinate: coordinate,
      bounding_box: BoundingBoxRepository.find_containing(repository, coordinate)
    }
  end

  defp no_bounding_box?(%{bounding_box: nil}), do: true
  defp no_bounding_box?(_), do: false
end
