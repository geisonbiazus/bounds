defmodule Bounds do
  def assign_coordinates(pairs_file_path, coordinates_file_path) do
    Bounds.ImportCoordinatesService.run(pairs_file_path, coordinates_file_path)
  end
end
