defmodule Hangman do
  # def new_game(client_pid) do
  #   GenServer.call(:connect_server, {:register_pids, nil, client_pid, nil})
  #   {:ok, pid} = Supervisor.start_child(Hangman.Supervisor, [])
  #   pid
  # end

  def new_game() do
    # GenServer.call(:connect_server, {:register_pids, nil, client_pid, nil})
    {:ok, pid} = Supervisor.start_child(Hangman.Supervisor, [])
    pid
  end

  def tally(server_pid) do
    GenServer.call(server_pid, {:tally})
  end

  def make_move(server_pid, guess) do
    GenServer.call(server_pid, {:make_move, guess})
  end

  def get_answer(server_pid) do
    GenServer.call(server_pid, {:get_answer})
  end

  # def register_pid(server_pid, client_pid, client_node) do
  #   state = GenServer.call(:connect_server, {:register_pids, server_pid, client_pid, client_node})
  #   IO.inspect(state)
  # end
end
