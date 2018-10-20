defmodule Bounds.BoundingBoxBuilder do
  defstruct list: [], last_coord: nil

  def new do
    %Bounds.BoundingBoxBuilder{}
  end

  def add_coord(%{last_coord: nil} = builder, coord) do
    %{builder | last_coord: coord}
  end

  def add_coord(%{list: list, last_coord: last_coord}, coord) do
    %Bounds.BoundingBoxBuilder{
      list: [Bounds.BoundingBox.new(last_coord, coord) | list]
    }
  end

  def build_list(coordinates) do
    coordinates
    |> Enum.reduce(new(), &add_coord(&2, &1))
    |> Map.fetch!(:list)
  end
end
