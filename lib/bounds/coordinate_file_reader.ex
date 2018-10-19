defmodule Bounds.CoordinateFileReader do
  def read(stream) do
    stream
    |> Stream.drop(1)
    |> Stream.map(&String.split(&1, ","))
    |> Stream.map(&to_coordinate(&1))
    |> Stream.filter(fn x -> !is_nil(x) end)
  end

  defp to_coordinate([lon, lat]) do
    {lon, _} = Float.parse(lon)
    {lat, _} = Float.parse(lat)
    Bounds.Coordinate.new(lon, lat)
  end

  defp to_coordinate(_) do
    nil
  end
end
