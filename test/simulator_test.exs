defmodule SimulatorTest do
  use ExUnit.Case

  setup do
    %{simulator: start_supervised!(Simulator)}
  end

  test "returns error when robot reports before being placed", %{simulator: simulator} do
    assert Simulator.report(simulator) == :error
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

  test "correct robot vector after 4 right rotation", %{simulator: simulator} do
    Simulator.place(simulator, {0, 0, "NORTH"})
    Simulator.rotate(simulator, "right")
    Simulator.rotate(simulator, "right")
    Simulator.rotate(simulator, "right")
    Simulator.rotate(simulator, "right")
    assert Simulator.report(simulator) == %{x: 0, y: 0, face: "NORTH"}
  end
end
