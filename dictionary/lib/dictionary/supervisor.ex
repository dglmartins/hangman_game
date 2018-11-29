defmodule Dictionary.Supervisor do
  use Supervisor

  def start_link() do
    IO.puts("Starting the top level dictionary supervisor...")
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    children = [
      Dictionary.WordList
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
