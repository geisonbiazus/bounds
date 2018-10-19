defmodule Bounds.CoordinateFileReader do
  def read(rows) do
    rows
    |> skip_header
    |> split_columns
    |> convert_into_coordinates
    |> remove_nil
  end

  defp skip_header(rows) do
    Stream.drop(rows, 1)
  end

  defp split_columns(rows) do
    Stream.map(rows, &String.split(&1, ","))
  end

  defp convert_into_coordinates(rows) do
    Stream.map(rows, &to_coordinate(&1))
  end

  defp to_coordinate([lon, lat]) do
    {lon, _} = Float.parse(lon)
    {lat, _} = Float.parse(lat)
    Bounds.Coordinate.new(lon, lat)
  end

  defp to_coordinate(_), do: nil

  defp remove_nil(rows) do
    Stream.filter(rows, fn x -> !is_nil(x) end)
  end
end
