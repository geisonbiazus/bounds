defmodule Bounds.Entities.BoundingBoxRepository do
  alias Bounds.Entities.{BoundingBoxRepository, BoundingBox}

  defstruct data: []

  def new, do: %BoundingBoxRepository{}

  def add(repo, bounding_box) do
    %{repo | data: [bounding_box | repo.data]}
  end

  def all(repo) do
    repo.data
  end

  def find_containing(%{data: data}, coordinate) do
    Enum.find(data, &BoundingBox.contains?(&1, coordinate))
  end

  def find_all_containing(%{data: data}, coordinate) do
    Enum.filter(data, &BoundingBox.contains?(&1, coordinate))
  end
end
