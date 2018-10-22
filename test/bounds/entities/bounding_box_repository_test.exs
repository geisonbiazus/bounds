defmodule Bounds.BoundingBoxRepositoryTest do
  alias Bounds.Entities.BoundingBoxRepository, as: Repository
  alias Bounds.Entities.{BoundingBox, Coordinate}

  use ExUnit.Case, async: true

  describe "add" do
    test "adds a bounding box" do
      repo = Repository.new()
      box_1 = BoundingBox.new(1, 1, 2, 2)
      box_2 = BoundingBox.new(3, 3, 4, 4)

      repo = Repository.add(repo, box_1)
      repo = Repository.add(repo, box_2)

      assert Repository.all(repo) == [box_2, box_1]
    end
  end

  describe "find_containing" do
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

  describe "find_all_containing" do
    test "returns all bounding boxes maching the coordinate" do
      repo = Repository.new()
      box_1 = BoundingBox.new(1, 1, 4, 4)
      box_2 = BoundingBox.new(2, 2, 5, 5)
      box_3 = BoundingBox.new(6, 6, 7, 7)

      repo = Repository.add(repo, box_1)
      repo = Repository.add(repo, box_2)
      repo = Repository.add(repo, box_3)

      assert Repository.find_all_containing(repo, Coordinate.new(3, 3)) == [
               box_2,
               box_1
             ]
    end
  end
end
