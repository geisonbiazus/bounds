defmodule Bounds.Coordinate do
  defstruct lon: 0, lat: 0

  def new(lon, lat) do
    %Bounds.Coordinate{lon: lon, lat: lat}
  end
end
