defmodule Bounds.AssignCoordinates do
  def run(pairs_file_path, coordinates_file_path) do
    repository = Bounds.BoundingBoxRepository.new()

    repository =
      pairs_file_path
      |> File.stream!()
      |> Bounds.CoordinateFileReader.read()
      |> Bounds.BoundingBox.build_list()
      |> Enum.reduce(repository, &Bounds.BoundingBoxRepository.add(&2, &1))

    coordinates =
      coordinates_file_path
      |> File.stream!()
      |> Bounds.CoordinateFileReader.read()

    Bounds.CoordinateAssigner.assign(repository, coordinates)
  end
end
