defmodule Bounds.ImportCoordinatesService do
  def run(pairs_file_path) do
    pairs_file_path
    |> File.stream!()
    |> Bounds.CoordinateFileReader.read()
    |> Bounds.BoundingBoxBuilder.build_list()
  end
end
