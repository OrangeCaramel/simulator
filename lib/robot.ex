defmodule Robot do
  use GenServer

  # Client
  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def report(pid) do
    GenServer.call(pid, :report)
  end

  def update(pid, new_state) do
    GenServer.call(pid, {:update, new_state})
  end

  # Server
  @impl true
  def init(:ok) do
    {:ok, %{}}
  end

  @impl true
  def handle_call(:report, _from, state) do
    {:reply, state, state}
  end

  def handle_call({:update, new_state}, _from, _state) do
    {:reply, :ok, new_state}
  end
end
