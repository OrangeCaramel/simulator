defmodule Utils do
  @doc """
    Helper functions
  """
  # Convert cardinal face directions to degrees
  def convert_face_to_deg("NORTH"), do: 0
  def convert_face_to_deg("EAST"), do: 90
  def convert_face_to_deg("SOUTH"), do: 180
  def convert_face_to_deg("WEST"), do: 270

  def convert_deg_to_face(degree) do
    cond do
      degree in [0, 360] -> "NORTH"
      degree == 90 -> "EAST"
      degree == 180 -> "SOUTH"
      degree in [-90, 270] -> "WEST"
    end
  end
end
