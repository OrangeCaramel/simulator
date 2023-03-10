defmodule InputUI do
  def start_link do
    Task.start_link(fn ->
      IO.puts(~S"""
      Welcome to the Simulator!

      Commands:
        PLACE X,Y,[NORTH|EAST|WEST|SOUTH]
        MOVE
        LEFT
        RIGHT
        REPORT
        REVERSE
      """)

      loop()
    end)
  end

  defp loop() do
    input = IO.gets("> ")

    unless input == :eof do
      String.trim(input)
      |> String.upcase()
      |> handle_input()
    else
      System.stop(0)
    end

    loop()
  end

  defp handle_input("PLACE" <> args) do
    placement =
      Regex.named_captures(
        ~r/(?<x>\d+),(?<y>\d+),(?<face>(NORTH|EAST|SOUTH|WEST))/,
        String.trim(args)
      )

    if placement do
      Simulator.place(:simulator_server, %{
        x: String.to_integer(placement["x"]),
        y: String.to_integer(placement["y"]),
        face: placement["face"]
      })
    end
  end

  defp handle_input("MOVE"), do: Simulator.move(:simulator_server)
  defp handle_input("REVERSE"), do: Simulator.reverse(:simulator_server)

  defp handle_input("REPORT") do
    Simulator.report(:simulator_server)
    |> print_report()
  end

  defp handle_input(rotation) when rotation in ["LEFT", "RIGHT"],
    do: Simulator.rotate(:simulator_server, rotation)

  defp handle_input(_), do: nil

  defp print_report(:noop), do: nil
  defp print_report(robot), do: IO.puts("Output: #{robot.x},#{robot.y},#{robot.face}")
end
