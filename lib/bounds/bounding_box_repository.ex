defmodule Bounds.BoundingBoxRepository do
  defstruct data: []

  def new, do: %Bounds.BoundingBoxRepository{}

  def add(repo, bounding_box) do
    %{repo | data: [bounding_box | repo.data]}
  end

  def all(repo) do
    repo.data
  end

  def find_containing(%{data: data}, coordinate) do
    Enum.find(data, &Bounds.BoundingBox.contains?(&1, coordinate))
  end

  def find_all_containing(%{data: data}, coordinate) do
    Enum.filter(data, &Bounds.BoundingBox.contains?(&1, coordinate))
  end
end
