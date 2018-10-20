defmodule Bounds.ImportCoordinatesServiceTest do
  use ExUnit.Case, async: true

  test "imports a pairs file and generates bounding boxes" do
    pairs_path = "#{__DIR__}/files/pairs.csv"
    list = Bounds.ImportCoordinatesService.run(pairs_path)

    assert list == [
             Bounds.BoundingBox.new(1.0, 3.0, 9.0, 8.0),
             Bounds.BoundingBox.new(1.3, 2.3, 2.5, 5.3)
           ]
  end
end
