defmodule Bounds do
  defmodule AppState do
    defstruct bounding_box_repository: Bounds.BoundingBoxRepository.new()
  end

  def new do
    %Bounds.AppState{}
  end

  def assign_coordinates(pairs_file_path, coordinates_file_path) do
    Bounds.AssignCoordinates.run(pairs_file_path, coordinates_file_path)
  end

  def bounding_boxes_for(app_state, origin, destination) do
    {result, repository} =
      Bounds.GetOriginAndDestinationBoundingBoxesService.run(
        app_state.bounding_box_repository,
        origin,
        destination
      )

    {%{app_state | bounding_box_repository: repository}, result}
  end
end
