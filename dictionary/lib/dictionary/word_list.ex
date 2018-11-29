defmodule Dictionary.WordList do
  @name __MODULE__

  use Agent

  def start_link(_arg) do
    Agent.start_link(&word_list/0, name: @name)
  end

  def word_list() do
    "../../assets/words.txt"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split(~r/\n/)
  end

  def random_word() do
    Agent.get(@name, &Enum.random/1)
  end
end
