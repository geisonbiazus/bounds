defmodule Bounds.ImportCoordinatesService do
  def run(pairs_file_path) do
    builder = Bounds.BoundingBoxBuilder.new()

    builder =
      Bounds.CoordinateFileReader.read(File.stream!(pairs_file_path))
      |> Enum.reduce(builder, fn coord, builder ->
        Bounds.BoundingBoxBuilder.add_coord(builder, coord)
      end)

    builder.list
  end
end
