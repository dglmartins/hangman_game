defmodule Hangman.Server do
  alias Hangman.Game
  use GenServer

  def start_link(_args) do
    GenServer.start_link(__MODULE__, nil)
    |> IO.inspect()
  end

  def init(_args) do
    IO.puts("Starting a hangman game server...")
    {:ok, Game.new_game()}
  end

  # def init(_args) do
  #   IO.puts("Starting a hangman game server...")
  #   count = GenServer.call(:connect_server, {:get_count})
  #   IO.puts("Num of connections: #{count}")
  #   {:ok, Game.new_game()}
  # end

  def handle_call({:make_move, guess}, _from, game) do
    {game, tally} = Game.make_move(game, guess)
    {:reply, tally, game}
  end

  def handle_call({:tally}, _from, game) do
    {:reply, Game.tally(game), game}
  end

  def handle_call({:get_answer}, _from, game) do
    answer = Enum.join(game.letters, "")
    {:reply, answer, game}
  end
end
