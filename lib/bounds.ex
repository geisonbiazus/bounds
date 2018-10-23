defmodule Bounds do
  alias Bounds.Services.{AssignCoordinatesService, GetOriginAndDestinationBoundingBoxesService}
  alias Bounds.Entities.BoundingBoxRepository

  defmodule AppState do
    defstruct bounding_box_repository: BoundingBoxRepository.new()
  end

  @doc """
  Initialize Bounds library

  Returns the application state
  """
  def new do
    %Bounds.AppState{}
  end

  @doc """
  Given an AppState, the path of a pairs and the path of a coordinates CSV file,
  generates and stores bounding boxes of the given pairs and assigns each
  coordinate to one of the generated bounding boxes.

  Returns the application state and a list of coordinates with the assigned
  bounding boxes
  """
  def assign_coordinates(app_state, pairs_file_path, coordinates_file_path) do
    {repository, result} =
      AssignCoordinatesService.run(
        app_state.bounding_box_repository,
        pairs_file_path,
        coordinates_file_path
      )

    {%{app_state | bounding_box_repository: repository}, result}
  end

  @doc """
  Given an AppState and an origin and destination coordinate, returns the stored
  bounding boxes that contains each coordinate. It also stores the new coordinates
  as a new bounding box

  The given coordinates must be in the format: {lon, lat}

  Returns AppState and the coordinates with the bounding boxes
  """
  def bounding_boxes_for(app_state, origin, destination) do
    {repository, result} =
      GetOriginAndDestinationBoundingBoxesService.run(
        app_state.bounding_box_repository,
        origin,
        destination
      )

    {%{app_state | bounding_box_repository: repository}, result}
  end
end
