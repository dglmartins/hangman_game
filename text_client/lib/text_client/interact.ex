defmodule TextClient.Interact do
  @hangman_server :"hangman@Danilos-MacBook-Pro"
  alias TextClient.{State, Player}

  def start() do
    new_game()
    # |> register_pid()
    |> setup_state()
    |> Player.play()
  end

  # def register_pid(server_pid) do
  #   client_node = Node.self()
  #   client_pid = self()
  #
  #   :rpc.call(
  #     @hangman_server,
  #     Hangman,
  #     :register_pid,
  #     [server_pid, client_pid, client_node]
  #   )
  #
  #   server_pid
  # end

  defp setup_state(server_pid) do
    %State{
      game_service: server_pid,
      tally: Hangman.tally(server_pid)
    }
  end

  # defp new_game() do
  #   client_pid = self()
  #   Node.connect(@hangman_server)
  #
  #   :rpc.call(
  #     @hangman_server,
  #     Hangman,
  #     :new_game,
  #     [client_pid]
  #   )
  # end

  defp new_game() do
    Node.connect(@hangman_server)

    :rpc.call(
      @hangman_server,
      Hangman,
      :new_game,
      []
    )
  end
end
