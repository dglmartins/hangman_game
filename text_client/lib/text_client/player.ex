defmodule TextClient.Player do
  alias TextClient.{State, Summary, Prompter, Mover}

  # won, lost, goodguess, bad guess, already used, initializing
  def play(%State{tally: %{game_state: :won}}) do
    exit_with_message("You WON!")
  end

  def play(%State{tally: %{game_state: :lost}} = game) do
    answer = Hangman.get_answer(game.game_service)
    exit_with_message("Sorry you lost, the answer was #{answer}")
  end

  def play(%State{tally: %{game_state: :good_guess}} = game) do
    continue_with_message(game, "Good guess")
  end

  def play(%State{tally: %{game_state: :bad_guess}} = game) do
    continue_with_message(game, "Sorry that isnt in the word.")
  end

  def play(%State{tally: %{game_state: :already_used}} = game) do
    continue_with_message(game, "You've already used that letter.")
  end

  def play(game) do
    continue(game)
  end

  def continue_with_message(game, msg) do
    IO.puts(msg)
    continue(game)
  end

  def continue(game) do
    game
    |> Summary.display()
    |> Prompter.accept_move()
    |> Mover.make_move()
    |> play()
  end

  defp exit_with_message(msg) do
    IO.puts(msg)
    exit(:normal)
  end

  # defp exit_with_message(msg) do
  #   IO.puts(msg)
  #   Process.exit(self(), :game_over)
  # end
end
