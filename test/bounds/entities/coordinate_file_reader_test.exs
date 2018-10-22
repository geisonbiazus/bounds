defmodule Bounds.CoordinateFileReaderTest do
  use ExUnit.Case, async: true

  alias Bounds.Entities.{CoordinateFileReader, Coordinate}

  test "reads a multiline stream and retuns a coordinate stream" do
    stream = [
      "lon,lat\n",
      "1,1\n",
      "3.3,4.4\n",
      "3.14,1234\n",
      "\n"
    ]

    coordinates =
      CoordinateFileReader.read(stream)
      |> Enum.to_list()

    assert coordinates == [
             Coordinate.new(1, 1),
             Coordinate.new(3.3, 4.4),
             Coordinate.new(3.14, 1234)
           ]
  end
end
