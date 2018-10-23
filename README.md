[![Build Status](https://travis-ci.org/geisonbiazus/bounds.svg?branch=master)](https://travis-ci.org/geisonbiazus/bounds)

# Bounds

## Challenge:

The test consists of two tasks:

### Task 1

You received two CSV files (pairs.csv and coordinates.csv) with two columns in each: longitude and latitude. You are asked to parse those files and handle their content like so:

**pairs.csv:**

- Create pairs of coordinates. e.g. [{lon1, lat1}, {lon2, lat2}], [{lon2, lat2}, {lon3, lat3}], [{lon3, lat3}, {lon4, lat4}], ...
- For every single pair, create a bounding box based on the two coordinates

**coordinates.csv:**

- Assign every coordinate to one of the previously computed bounding boxes given that the coordinate is inside a bounding box. If no bounding box matches, just discard the coordinate.

### Task 2

Given that the first part is complete, create a module that keeps track of every bounding box ever created (from the CSV file and via any API - e.g. the CLI) and takes a pair of geographic coordinates as argument (i.e. origin and destination) and returns the matching bounding boxes (for either origin, destination or both).

During the matching process, that module should also build and store the bounding box corresponding to the pair of geographic coordinates received as input.

## Solution Explanation

### Task 1

The solution code can be invoked with the following code inside an `iex` console:

```elixir
app_state = Bounds.new()
pairs_path = "#{__DIR__}/../resources/pairs.csv"
coordinates_path = "#{__DIR__}/../resources/coordinates.csv"
{app_state, result} = Bounds.assign_coordinates(app_state, pairs_path, coordinates_path)
```

Each part of the process was split into a small and reusable module. All these modules are in the `lib/bounds/entities` folder. The module `Bounds.Service.AssignCoordinatesService` is responsible to put all the small modules together. The process is the following:

- Read the pairs file as a Stream
- Build a list of Coordinates
- Build a list of Bounding Boxes with each pair of coordinates
- Read the coordinates file as a Stream
- Build a list of Coordinates
- Store all bounding boxes in the repository (to be used on Task 2).
- Assign each coordinate with the corresponding bounding box.

The assignment process is done looping through all the coordinates, for each one it loops through the bounding boxes to find the first matching one.

The algorithm complexity is `O(n + n / 2 + m * n / 2)` where the first `n` is the pairs, `m` is the coordinates and the last `n` is the pairs again which is halved because of the bounding boxes. Another `n / 2` was added in the middle to store the bounding boxes in the repository.

### Task 2

The solution code can be invoked with the following code inside an `iex` console:

```elixir
app_state = Bounds.new()

# Load the files to store some bounding boxes
pairs_path = "#{__DIR__}/../resources/pairs.csv"
coordinates_path = "#{__DIR__}/../resources/coordinates.csv"
{app_state, _} = Bounds.assign_coordinates(app_state, pairs_path, coordinates_path)

# Get the bounding boxes for origin and destination
{app_state, result} =
  Bounds.bounding_boxes_for(app_state, {120.9956, 14.5126}, {120.9724, 14.7462})
```

A `BoundingBoxRepository` was created to store all the bounding boxes ever created. In this example they are being stored in memory which means the added data is always returned when a function is invoked. This repository could be easily implemented using a database, so only the connection would be stored and returned in the command functions.

The actual implementation of the task is in the `Bounds.Services.GetOriginAndDestinationBoundingBoxesService` module. The process is the following:

- Create origin and destination coordinates based on the given arguments
- Find all the bounding boxes for each of them using the repository
- Store the coordinates as a new Bounding Box

The current complexity for finding the Bounding Boxes is `O(n)` where `n` is the number of Bounding Boxes stored. If this repository had real database implementation, some database specific functions and indexes could be used to speed up the process. Postgres and Elasticsearch have functions to deal with coordinates.

The overall application is divided into:

- Entities - Small focused and reusable modules
- Services - Where the business logic are. They make the entities work together.
- Main - It is the `Bounds` module. It controls the app state and is responsible for invoking the services with the right dependencies.
- Every module has its own unit tests
- The file `test/bounds_test.exs` has the application acceptance tests.
