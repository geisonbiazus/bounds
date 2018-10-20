defmodule Bounds.ImportCoordinatesService do
  def run(pairs_file_path, coordinates_file_path) do
    bounding_boxes =
      pairs_file_path
      |> File.stream!()
      |> Bounds.CoordinateFileReader.read()
      |> Bounds.BoundingBoxBuilder.build_list()

    coordinates =
      coordinates_file_path
      |> File.stream!()
      |> Bounds.CoordinateFileReader.read()

    Bounds.CoordinateAssigner.assign(bounding_boxes, coordinates)
  end
end
