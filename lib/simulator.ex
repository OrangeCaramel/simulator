defmodule Simulator do
  use GenServer

  @min_x 0
  @min_y 0
  @max_x 5
  @max_y 5
  @robot_speed 1
  @clockwise_rotation 90
  @anti_clockwise_rotation -90

  # Client
  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def place(pid, placement) do
    GenServer.call(pid, {:place, placement})
  end

  def move(pid) do
    GenServer.call(pid, {:move, nil})
  end

  def rotate(pid, direction) do
    GenServer.call(pid, {:rotate, direction})
  end

  def report(pid) do
    GenServer.call(pid, {:report, nil})
  end

  # Server
  @spec init(:ok) :: {:ok, %{is_robot_placed: false, robot: pid}}
  def init(:ok) do
    {:ok, robot} = Robot.start_link([])
    {:ok, %{is_robot_placed: false, robot: robot}}
  end

  def handle_call({:place, {x, y, face}}, _from, state) do
    new_robot_state = %{x: x, y: y, face: face}
    Robot.update(state.robot, new_robot_state)

    new_state = Map.put(state, :is_robot_placed, true)
    {:reply, :ok, new_state}
  end

  def handle_call({command, _}, _from, state)
      when not state.is_robot_placed and command in [:report, :rotate, :move],
      do: {:reply, :noop, state}

  def handle_call({:report, _}, _from, state) do
    {:reply, Robot.report(state.robot), state}
  end

  def handle_call({:rotate, direction}, _from, state) do
    current_robot_state = Robot.report(state.robot)

    rotation_value =
      if direction == "right", do: @clockwise_rotation, else: @anti_clockwise_rotation

    new_face =
      Utils.convert_face_to_deg(current_robot_state.face)
      |> Kernel.+(rotation_value)
      |> Utils.convert_deg_to_face()

    new_robot_state = Map.put(current_robot_state, :face, new_face)

    Robot.update(state.robot, new_robot_state)

    {:reply, :ok, state}
  end
end
