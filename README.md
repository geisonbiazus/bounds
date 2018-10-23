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

The assignment process is done looping through all the coordinates, for each one loop though the bounding boxes to find the first matching one.

The algorithm complexity is O(2n + m \* n)
