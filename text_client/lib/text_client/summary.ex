defmodule TextClient.Summary do
  def display(%{tally: tally} = game) do
    IO.puts([
      "\n",
      "Words so far: #{Enum.join(tally.letters, " ")}\n",
      "Guesses left: #{tally.turns_left}\n",
      "Used: #{Enum.join(tally.used, " ")}\n"
    ])

    game
  end
end
