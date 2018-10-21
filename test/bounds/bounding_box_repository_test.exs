defmodule Bounds.BoundingBoxRepositoryTest do
  alias Bounds.BoundingBoxRepository, as: Repository
  alias Bounds.{BoundingBox, Coordinate}

  use ExUnit.Case, async: true

  test "adds a bounding box" do
    repo = Repository.new()
    box_1 = BoundingBox.new(1, 1, 2, 2)
    box_2 = BoundingBox.new(3, 3, 4, 4)

    repo = Repository.add(repo, box_1)
    repo = Repository.add(repo, box_2)

    assert Repository.all(repo) == [box_2, box_1]
  end

  test "returns the bounding box that contains the given coordinate" do
    repo = Repository.new()
    box_1 = BoundingBox.new(1, 1, 2, 2)
    box_2 = BoundingBox.new(3, 3, 4, 4)

    repo = Repository.add(repo, box_1)
    repo = Repository.add(repo, box_2)

    assert Repository.find_containing(repo, Coordinate.new(1.5, 1.5)) == box_1
    assert Repository.find_containing(repo, Coordinate.new(3.5, 3.5)) == box_2
    assert Repository.find_containing(repo, Coordinate.new(4.5, 4.5)) == nil
  end
end
