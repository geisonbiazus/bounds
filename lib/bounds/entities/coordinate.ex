defmodule Bounds.Entities.Coordinate do
  alias Bounds.Entities.Coordinate

  defstruct lon: 0, lat: 0

  def new(lon, lat) do
    %Coordinate{lon: lon, lat: lat}
  end
end
