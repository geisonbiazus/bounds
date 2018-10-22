defmodule Bounds.AssignCoordinates do
  alias Bounds.{CoordinateFileReader, BoundingBox, CoordinateAssigner, BoundingBoxRepository}

  def run(repository, pairs_file_path, coordinates_file_path) do
    bounding_boxes =
      pairs_file_path
      |> File.stream!()
      |> CoordinateFileReader.read()
      |> BoundingBox.build_list()
      |> Enum.to_list()

    coordinates =
      coordinates_file_path
      |> File.stream!()
      |> CoordinateFileReader.read()

    repository =
      bounding_boxes
      |> Enum.reduce(repository, &BoundingBoxRepository.add(&2, &1))

    {repository, CoordinateAssigner.assign(bounding_boxes, coordinates)}
  end
end
