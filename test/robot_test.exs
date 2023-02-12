defmodule RobotTest do
  use ExUnit.Case, async: true

  setup do
    %{robot: start_supervised!(Robot)}
  end

  test "reports state", %{robot: robot} do
    assert Robot.report(robot) == %{}
  end

  test "updates state", %{robot: robot} do
    assert Robot.report(robot) == %{}
    Robot.update(robot, %{x: 0, y: 0, face: "NORTH"})
    assert Robot.report(robot) == %{x: 0, y: 0, face: "NORTH"}
  end
end
