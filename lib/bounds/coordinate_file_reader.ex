defmodule Bounds.CoordinateFileReader do
  def read(stream, builder) do
    stream
    |> Stream.chunk_every(5)
    |> Enum.reduce(builder, fn item, builder ->
      Bounds.CoordinateBuilder.add_coord(builder, Bounds.Coordinate.new(1, 1))
    end)
  end
end
