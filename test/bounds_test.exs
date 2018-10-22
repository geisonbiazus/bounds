defmodule BoundsTest do
  use ExUnit.Case

  describe "assign_coordinates" do
    test "imports and assigns coordinate files" do
      app_state = Bounds.new()
      pairs_path = "#{__DIR__}/../resources/pairs.csv"
      coordinates_path = "#{__DIR__}/../resources/coordinates.csv"
      {app_state, result} = Bounds.assign_coordinates(app_state, pairs_path, coordinates_path)

      assert result == [
               %{
                 bounding_box: %Bounds.BoundingBox{
                   northeast: %Bounds.Coordinate{
                     lat: 14.475110000000003,
                     lon: 121.00115999999998
                   },
                   southwest: %Bounds.Coordinate{
                     lat: 14.473830000000003,
                     lon: 120.99969999999999
                   }
                 },
                 coordinate: %Bounds.Coordinate{lat: 14.4743, lon: 121.001}
               },
               %{
                 bounding_box: %Bounds.BoundingBox{
                   northeast: %Bounds.Coordinate{lat: 14.59343, lon: 120.97985000000001},
                   southwest: %Bounds.Coordinate{lat: 14.59234, lon: 120.97901000000002}
                 },
                 coordinate: %Bounds.Coordinate{lat: 14.5926, lon: 120.9798}
               },
               %{
                 bounding_box: %Bounds.BoundingBox{
                   northeast: %Bounds.Coordinate{lat: 14.51318, lon: 120.99562},
                   southwest: %Bounds.Coordinate{lat: 14.51064, lon: 120.99506000000001}
                 },
                 coordinate: %Bounds.Coordinate{lat: 14.5126, lon: 120.9956}
               },
               %{
                 bounding_box: %Bounds.BoundingBox{
                   northeast: %Bounds.Coordinate{lat: 14.746730000000003, lon: 120.97252},
                   southwest: %Bounds.Coordinate{lat: 14.745920000000003, lon: 120.97217}
                 },
                 coordinate: %Bounds.Coordinate{lat: 14.7462, lon: 120.9724}
               },
               %{
                 bounding_box: %Bounds.BoundingBox{
                   northeast: %Bounds.Coordinate{
                     lat: 14.471230000000006,
                     lon: 120.99795999999999
                   },
                   southwest: %Bounds.Coordinate{
                     lat: 14.469610000000005,
                     lon: 120.99708999999999
                   }
                 },
                 coordinate: %Bounds.Coordinate{lat: 14.4704, lon: 120.9971}
               }
             ]

      assert length(Bounds.BoundingBoxRepository.all(app_state.bounding_box_repository)) == 164
    end
  end

  describe "bounding_boxes_for" do
    test "returns updated state and the matching bounding boxes for origin and destination" do
      app_state = Bounds.new()
      pairs_path = "#{__DIR__}/../resources/pairs.csv"
      coordinates_path = "#{__DIR__}/../resources/coordinates.csv"
      {app_state, _} = Bounds.assign_coordinates(app_state, pairs_path, coordinates_path)

      {app_state, result} =
        Bounds.bounding_boxes_for(app_state, {120.9956, 14.5126}, {120.9724, 14.7462})

      assert result == [
               %{
                 bounding_boxes: [
                   %Bounds.BoundingBox{
                     northeast: %Bounds.Coordinate{lat: 14.51318, lon: 120.99562},
                     southwest: %Bounds.Coordinate{lat: 14.51064, lon: 120.99506000000001}
                   }
                 ],
                 coordinate: %Bounds.Coordinate{lat: 14.5126, lon: 120.9956}
               },
               %{
                 bounding_boxes: [
                   %Bounds.BoundingBox{
                     northeast: %Bounds.Coordinate{lat: 14.746730000000003, lon: 120.97252},
                     southwest: %Bounds.Coordinate{lat: 14.745920000000003, lon: 120.97217}
                   }
                 ],
                 coordinate: %Bounds.Coordinate{lat: 14.7462, lon: 120.9724}
               }
             ]

      assert length(Bounds.BoundingBoxRepository.all(app_state.bounding_box_repository)) == 165
    end
  end
end
