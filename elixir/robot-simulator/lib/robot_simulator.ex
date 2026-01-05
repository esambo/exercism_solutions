defmodule RobotSimulator do
  @moduledoc """
  Robot Simulator.
  """

  @typedoc """
  A direction.
  Valid directions are: `:north`, `:east`, `:south`, `:west`.
  """
  @type direction() :: :north | :east | :south | :west

  @typedoc """
  Position coordinates x and y, increasing to the north and east.
  """
  @type position() :: {integer(), integer()}

  @typedoc """
  A robot with a direction and position.
  """
  @type robot :: %{direction: atom(), position: {integer, integer}}

  @doc """
  Create a Robot Simulator given an initial direction and position.
  """
  @spec create(direction, position) :: robot() | {:error, String.t()}
  def create(direction \\ :north, position \\ {0, 0})

  def create(direction, {x, y} = position)
      when direction in ~w[north east south west]a and is_integer(x) and is_integer(y) do
    %{direction: direction, position: position}
  end

  def create(direction, _position) when direction in ~w[north east south west]a do
    {:error, "invalid position"}
  end

  def create(_direction, {x, y} = _position) when is_integer(x) and is_integer(y) do
    {:error, "invalid direction"}
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot, instructions :: String.t()) :: robot() | {:error, String.t()}
  def simulate(%{direction: :north} = robot, "L" <> remaining_instructions) do
    robot
    |> Map.merge(%{direction: :west})
    |> simulate(remaining_instructions)
  end

  def simulate(%{direction: :north} = robot, "R" <> remaining_instructions) do
    robot
    |> Map.merge(%{direction: :east})
    |> simulate(remaining_instructions)
  end

  def simulate(%{direction: :north, position: {x, y}} = robot, "A" <> remaining_instructions) do
    robot
    |> Map.merge(%{position: {x, y + 1}})
    |> simulate(remaining_instructions)
  end

  def simulate(%{direction: :west} = robot, "L" <> remaining_instructions) do
    robot
    |> Map.merge(%{direction: :south})
    |> simulate(remaining_instructions)
  end

  def simulate(%{direction: :west} = robot, "R" <> remaining_instructions) do
    robot
    |> Map.merge(%{direction: :north})
    |> simulate(remaining_instructions)
  end

  def simulate(%{direction: :west, position: {x, y}} = robot, "A" <> remaining_instructions) do
    robot
    |> Map.merge(%{position: {x - 1, y}})
    |> simulate(remaining_instructions)
  end

  def simulate(%{direction: :south} = robot, "L" <> remaining_instructions) do
    robot
    |> Map.merge(%{direction: :east})
    |> simulate(remaining_instructions)
  end

  def simulate(%{direction: :south} = robot, "R" <> remaining_instructions) do
    robot
    |> Map.merge(%{direction: :west})
    |> simulate(remaining_instructions)
  end

  def simulate(%{direction: :south, position: {x, y}} = robot, "A" <> remaining_instructions) do
    robot
    |> Map.merge(%{position: {x, y - 1}})
    |> simulate(remaining_instructions)
  end

  def simulate(%{direction: :east} = robot, "L" <> remaining_instructions) do
    robot
    |> Map.merge(%{direction: :north})
    |> simulate(remaining_instructions)
  end

  def simulate(%{direction: :east} = robot, "R" <> remaining_instructions) do
    robot
    |> Map.merge(%{direction: :south})
    |> simulate(remaining_instructions)
  end

  def simulate(%{direction: :east, position: {x, y}} = robot, "A" <> remaining_instructions) do
    robot
    |> Map.merge(%{position: {x + 1, y}})
    |> simulate(remaining_instructions)
  end

  def simulate(robot, "" = _no_remaining_instructions) do
    robot
  end

  def simulate(_robot, _invalid_instructions) do
    {:error, "invalid instruction"}
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot) :: direction()
  def direction(robot) do
    robot.direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot) :: position()
  def position(robot) do
    robot.position
  end
end
