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
end

defimpl Bounds.CoordinateBuilder, for: Bounds.BoundingBoxBuilder do
  def add_coord(builder, coord) do
    Bounds.BoundingBoxBuilder.add_coord(builder, coord)
  end
end
