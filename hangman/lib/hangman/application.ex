defmodule Hangman.Application do
  use Application

  def start(_type, _args) do
    IO.puts("Starting the Hangman application...")
    # in separate supervisor
    Hangman.Supervisor.start_link()
    # Hangman.ConnectAgent.start_link()
    Hangman.ConnectServer.start_link()
  end
end
