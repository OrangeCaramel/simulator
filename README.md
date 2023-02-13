# Simulator

An application which prompts for commands to simulate the movement of a robot in a 5x5 grid.

| Environment | Version |
| ----------- | --------|
| Elixir      | 1.14.3  |

## Building and Running Application

1. `mix compile`
2. `mix release --overwrite`
3. `_build/dev/rel/simulator/bin/simulator start`

## Testing

Run unit tests
- `mix test`

Test the application from a file
- `_build/dev/rel/simulator/bin/simulator start < test/scenarios/scenario_a.txt`
