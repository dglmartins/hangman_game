defmodule Hangman.ConnectServer do
  @name :connect_server
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, nil, name: @name)
  end

  def init(_args) do
    IO.puts("Starting the connect_server...")

    {:ok, %{connected_nodes: %{}}}
  end

  def handle_call({:get_count}, _from, state) do
    {:reply, Enum.count(state.connected_nodes), state}
  end

  def handle_call({:register_pids, nil, client_pid, nil}, _from, state) do
    Process.monitor(client_pid)

    new_connected_nodes = Map.put(state.connected_nodes, client_pid, %{})

    new_state = %{state | connected_nodes: new_connected_nodes}
    {:reply, new_state, new_state}
  end

  def handle_call({:register_pids, server_pid, client_pid, client_node}, _from, state) do
    new_connected_nodes =
      Map.put(state.connected_nodes, client_pid, %{
        server_pid: server_pid,
        client_node: client_node
      })

    new_state = %{state | connected_nodes: new_connected_nodes}
    {:reply, new_state, new_state}
  end

  def handle_info({:DOWN, _ref, :process, pid, _reason}, state) do
    new_connected_nodes = Map.drop(state.connected_nodes, [pid])
    new_state = %{state | connected_nodes: new_connected_nodes}
    dropped_pid_map = Map.get(state.connected_nodes, pid)
    server_pid = dropped_pid_map.server_pid
    IO.inspect(server_pid)
    GenServer.stop(server_pid, :normal)

    {:noreply, new_state}
  end
end
