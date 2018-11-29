defmodule Hangman.Supervisor do
  use Supervisor

  def start_link() do
    IO.puts("Starting the top level hangman supervisor...")
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    children = [
      Supervisor.child_spec({Hangman.Server, []}, restart: :transient)
    ]

    Supervisor.init(children, strategy: :simple_one_for_one)
  end
end
