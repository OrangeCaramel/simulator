defmodule SimulatorTest do
  use ExUnit.Case

  setup do
    %{simulator: start_supervised!(Simulator)}
  end

  test "does nothing when a command is called before robot is placed", %{
    simulator: simulator
  } do
    assert Simulator.report(simulator) == :noop
    assert Simulator.rotate(simulator, "left") == :noop
    assert Simulator.rotate(simulator, "right") == :noop
  end

  test "places robot at origin facing NORTH", %{simulator: simulator} do
    Simulator.place(simulator, {0, 0, "NORTH"})
    assert Simulator.report(simulator) == %{x: 0, y: 0, face: "NORTH"}
  end

  test "correct robot vector after one right rotation", %{simulator: simulator} do
    Simulator.place(simulator, {0, 0, "NORTH"})
    Simulator.rotate(simulator, "right")
    assert Simulator.report(simulator) == %{x: 0, y: 0, face: "EAST"}
  end

  test "correct robot vector after 4 right rotations", %{simulator: simulator} do
    Simulator.place(simulator, {0, 0, "NORTH"})
    Simulator.rotate(simulator, "right")
    Simulator.rotate(simulator, "right")
    Simulator.rotate(simulator, "right")
    Simulator.rotate(simulator, "right")
    assert Simulator.report(simulator) == %{x: 0, y: 0, face: "NORTH"}
  end

  test "correct robot vector after one left rotation", %{simulator: simulator} do
    Simulator.place(simulator, {0, 0, "NORTH"})
    Simulator.rotate(simulator, "left")
    assert Simulator.report(simulator) == %{x: 0, y: 0, face: "WEST"}
  end

  test "correct robot vector after 4 left rotations", %{simulator: simulator} do
    Simulator.place(simulator, {0, 0, "NORTH"})

    Simulator.rotate(simulator, "left")
    Simulator.rotate(simulator, "left")
    Simulator.rotate(simulator, "left")
    Simulator.rotate(simulator, "left")
    assert Simulator.report(simulator) == %{x: 0, y: 0, face: "NORTH"}
  end

  test "correct robot vector after one move to the north", %{simulator: simulator} do
    Simulator.place(simulator, {0, 0, "NORTH"})
    Simulator.move(simulator)
    assert Simulator.report(simulator) == %{x: 0, y: 1, face: "NORTH"}
  end

  test "correct robot vector after one move to the south", %{simulator: simulator} do
    Simulator.place(simulator, {4, 4, "SOUTH"})
    Simulator.move(simulator)
    assert Simulator.report(simulator) == %{x: 4, y: 3, face: "SOUTH"}
  end

  test "correct robot vector after one move to the east", %{simulator: simulator} do
    Simulator.place(simulator, {2, 2, "EAST"})
    Simulator.move(simulator)
    assert Simulator.report(simulator) == %{x: 3, y: 2, face: "EAST"}
  end

  test "correct robot vector after one move to the west", %{simulator: simulator} do
    Simulator.place(simulator, {2, 2, "WEST"})
    Simulator.move(simulator)
    assert Simulator.report(simulator) == %{x: 1, y: 2, face: "WEST"}
  end
end
