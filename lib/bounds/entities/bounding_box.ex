defmodule Bounds.Entities.BoundingBox do
  alias Bounds.Entities.{Coordinate, BoundingBox}

  defstruct southwest: %Coordinate{}, northeast: %Coordinate{}

  def new(lon_a, lat_a, lon_b, lat_b) do
    new(Coordinate.new(lon_a, lat_a), Coordinate.new(lon_b, lat_b))
  end

  def new(coord_a, coord_b) do
    %BoundingBox{
      southwest: %Coordinate{
        lon: min(coord_a.lon, coord_b.lon),
        lat: min(coord_a.lat, coord_b.lat)
      },
      northeast: %Coordinate{
        lon: max(coord_a.lon, coord_b.lon),
        lat: max(coord_a.lat, coord_b.lat)
      }
    }
  end

  def contains?(box, coord) do
    coord.lon >= box.southwest.lon && coord.lon <= box.northeast.lon &&
      coord.lat >= box.southwest.lat && coord.lat <= box.northeast.lat
  end

  def build_list(coordinates) do
    coordinates
    |> Stream.chunk_every(2, 2, :discard)
    |> Stream.map(fn [a, b] -> BoundingBox.new(a, b) end)
  end
end
