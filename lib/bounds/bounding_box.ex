defmodule Bounds.BoundingBox do
  defstruct min_lon: 0, min_lat: 0, max_lon: 0, max_lat: 0

  def create(lon_a, lat_a, lon_b, lat_b) do
    %Bounds.BoundingBox{
      min_lon: min(lon_a, lon_b),
      min_lat: min(lat_a, lat_b),
      max_lon: max(lon_a, lon_b),
      max_lat: max(lat_a, lat_b)
    }
  end
end
