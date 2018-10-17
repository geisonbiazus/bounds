defmodule Bounds.BoundingBox do
  defstruct southwest: %Bounds.Coordinate{}, northeast: %Bounds.Coordinate{}

  def create(coord_a, coord_b) do
    %Bounds.BoundingBox{
      southwest: %Bounds.Coordinate{
        lon: min(coord_a.lon, coord_b.lon),
        lat: min(coord_a.lat, coord_b.lat)
      },
      northeast: %Bounds.Coordinate{
        lon: max(coord_a.lon, coord_b.lon),
        lat: max(coord_a.lat, coord_b.lat)
      }
    }
  end
end
