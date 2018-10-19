defmodule Bounds.CoordinateFileReaderTest do
  use ExUnit.Case, async: true

  test "reads a multiline stream and retuns a coordinate stream" do
    stream = [
      "lon,lat\n",
      "1,1\n",
      "3.3,4.4\n",
      "3.14,1234\n",
      "\n"
    ]

    coordinates =
      Bounds.CoordinateFileReader.read(stream)
      |> Enum.to_list()

    assert coordinates == [
             Bounds.Coordinate.new(1, 1),
             Bounds.Coordinate.new(3.3, 4.4),
             Bounds.Coordinate.new(3.14, 1234)
           ]
  end
end
