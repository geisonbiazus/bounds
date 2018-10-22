defmodule Bounds.GetOriginAndDestinationBoundingBoxesServiceTest do
  use ExUnit.Case, async: true

  alias Bounds.{Coordinate, BoundingBox, BoundingBoxRepository}

  setup do
    box_1 = BoundingBox.new(1, 1, 5, 5)
    box_2 = BoundingBox.new(10, 10, 15, 15)
    box_3 = BoundingBox.new(1, 1, 15, 15)

    repository =
      BoundingBoxRepository.new()
      |> BoundingBoxRepository.add(box_3)
      |> BoundingBoxRepository.add(box_1)
      |> BoundingBoxRepository.add(box_2)

    %{repository: repository, box_1: box_1, box_2: box_2, box_3: box_3}
  end

  test "returns the bounding boxes that match origin and destination", %{
    repository: repository,
    box_1: box_1,
    box_2: box_2,
    box_3: box_3
  } do
    origin = {2, 2}
    destination = {12, 12}

    result =
      Bounds.GetOriginAndDestinationBoundingBoxesService.run(repository, origin, destination)

    assert result == [
             %{
               coordinate: Coordinate.new(2, 2),
               bounding_boxes: [box_1, box_3]
             },
             %{
               coordinate: Coordinate.new(12, 12),
               bounding_boxes: [box_2, box_3]
             }
           ]
  end

  test "returns bounding_box nil if it doesn't match", %{
    repository: repository,
    box_1: box_1,
    box_3: box_3
  } do
    origin = {2, 2}
    destination = {120, 120}

    result =
      Bounds.GetOriginAndDestinationBoundingBoxesService.run(repository, origin, destination)

    assert result == [
             %{
               coordinate: Coordinate.new(2, 2),
               bounding_boxes: [box_1, box_3]
             },
             %{
               coordinate: Coordinate.new(120, 120),
               bounding_boxes: []
             }
           ]
  end
end
