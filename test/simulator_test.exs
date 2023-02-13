defmodule SimulatorTest do
  use ExUnit.Case

  setup do
    %{simulator: start_supervised!(Simulator)}
  end

  test "does nothing when a command is called before robot is placed", %{
    simulator: simulator
  } do
    assert Simulator.report(simulator) == :noop
    assert Simulator.rotate(simulator, "LEFT") == :noop
    assert Simulator.rotate(simulator, "RIGHT") == :noop
  end

  test "places robot at origin facing NORTH", %{simulator: simulator} do
    Simulator.place(simulator, %{x: 0, y: 0, face: "NORTH"})
    assert Simulator.report(simulator) == %{x: 0, y: 0, face: "NORTH"}
  end

  test "ignores placement of robot when its out of bounds", %{
    simulator: simulator
  } do
    Simulator.place(simulator, %{x: -1, y: 0, face: "NORTH"})
    assert Simulator.report(simulator) == :noop

    Simulator.place(simulator, %{x: 0, y: 0, face: "NORTH"})
    Simulator.place(simulator, %{x: 0, y: 5, face: "NORTH"})
    assert Simulator.report(simulator) == %{x: 0, y: 0, face: "NORTH"}
  end

  test "correct robot vector after one RIGHT rotation", %{simulator: simulator} do
    Simulator.place(simulator, %{x: 0, y: 0, face: "NORTH"})
    Simulator.rotate(simulator, "RIGHT")
    assert Simulator.report(simulator) == %{x: 0, y: 0, face: "EAST"}
  end

  test "correct robot vector after 4 RIGHT rotations", %{simulator: simulator} do
    Simulator.place(simulator, %{x: 0, y: 0, face: "NORTH"})
    Simulator.rotate(simulator, "RIGHT")
    Simulator.rotate(simulator, "RIGHT")
    Simulator.rotate(simulator, "RIGHT")
    Simulator.rotate(simulator, "RIGHT")
    assert Simulator.report(simulator) == %{x: 0, y: 0, face: "NORTH"}
  end

  test "correct robot vector after one LEFT rotation", %{simulator: simulator} do
    Simulator.place(simulator, %{x: 0, y: 0, face: "NORTH"})
    Simulator.rotate(simulator, "LEFT")
    assert Simulator.report(simulator) == %{x: 0, y: 0, face: "WEST"}
  end

  test "correct robot vector after 4 LEFT rotations", %{simulator: simulator} do
    Simulator.place(simulator, %{x: 0, y: 0, face: "NORTH"})

    Simulator.rotate(simulator, "LEFT")
    Simulator.rotate(simulator, "LEFT")
    Simulator.rotate(simulator, "LEFT")
    Simulator.rotate(simulator, "LEFT")
    assert Simulator.report(simulator) == %{x: 0, y: 0, face: "NORTH"}
  end

  test "correct robot vector after one move to the north", %{simulator: simulator} do
    Simulator.place(simulator, %{x: 0, y: 0, face: "NORTH"})
    Simulator.move(simulator)
    assert Simulator.report(simulator) == %{x: 0, y: 1, face: "NORTH"}
  end

  test "correct robot vector after one move to the south", %{simulator: simulator} do
    Simulator.place(simulator, %{x: 4, y: 4, face: "SOUTH"})
    Simulator.move(simulator)
    assert Simulator.report(simulator) == %{x: 4, y: 3, face: "SOUTH"}
  end

  test "correct robot vector after one move to the east", %{simulator: simulator} do
    Simulator.place(simulator, %{x: 2, y: 2, face: "EAST"})
    Simulator.move(simulator)
    assert Simulator.report(simulator) == %{x: 3, y: 2, face: "EAST"}
  end

  test "correct robot vector after one move to the west", %{simulator: simulator} do
    Simulator.place(simulator, %{x: 2, y: 2, face: "WEST"})
    Simulator.move(simulator)
    assert Simulator.report(simulator) == %{x: 1, y: 2, face: "WEST"}
  end

  test "ignores robot movement if going out of bounds", %{simulator: simulator} do
    Simulator.place(simulator, %{x: 0, y: 0, face: "WEST"})
    Simulator.move(simulator)
    assert Simulator.report(simulator) == %{x: 0, y: 0, face: "WEST"}

    Simulator.rotate(simulator, "LEFT")
    Simulator.move(simulator)
    assert Simulator.report(simulator) == %{x: 0, y: 0, face: "SOUTH"}

    Simulator.place(simulator, %{x: 4, y: 4, face: "NORTH"})
    Simulator.move(simulator)
    assert Simulator.report(simulator) == %{x: 4, y: 4, face: "NORTH"}

    Simulator.rotate(simulator, "RIGHT")
    Simulator.move(simulator)
    assert Simulator.report(simulator) == %{x: 4, y: 4, face: "EAST"}
  end
end
