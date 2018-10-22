defmodule Bounds do
  defmodule AppState do
    defstruct bounding_box_repository: Bounds.BoundingBoxRepository.new()
  end

  def new do
    %Bounds.AppState{}
  end

  def assign_coordinates(app_state, pairs_file_path, coordinates_file_path) do
    {repository, result} =
      Bounds.AssignCoordinates.run(
        app_state.bounding_box_repository,
        pairs_file_path,
        coordinates_file_path
      )

    {%{app_state | bounding_box_repository: repository}, result}
  end

  def bounding_boxes_for(app_state, origin, destination) do
    {repository, result} =
      Bounds.GetOriginAndDestinationBoundingBoxesService.run(
        app_state.bounding_box_repository,
        origin,
        destination
      )

    {%{app_state | bounding_box_repository: repository}, result}
  end
end
