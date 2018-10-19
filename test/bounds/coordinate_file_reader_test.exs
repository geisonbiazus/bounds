defmodule CoordinateBuilderSpy do
  defstruct list: []

  def add_coord(builder, coord) do
    %{builder | list: [coord | builder.list]}
  end

  defimpl Bounds.CoordinateBuilder, for: CoordinateBuilderSpy do
    def add_coord(builder, coord) do
      CoordinateBuilderSpy.add_coord(builder, coord)
    end
  end
end

defmodule Bounds.CoordinateFileReaderTest do
  use ExUnit.Case, async: true

  test "reads a csv stream and adds a coordinate to the builder" do
    stream = ["1,1"]
    builder = Bounds.CoordinateFileReader.read(stream, %CoordinateBuilderSpy{})
    assert builder.list == [Bounds.Coordinate.new(1, 1)]
  end
end
