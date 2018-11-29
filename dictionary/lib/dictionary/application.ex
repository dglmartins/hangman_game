defmodule Dictionary.Application do
  use Application

  def start(_type, _args) do
    IO.puts("Starting the dictionary application...")
    # in separate supervisor
    Dictionary.Supervisor.start_link()

    # new way
    # children = [
    #   {Dictionary.WordList, []}
    # ]
    #
    # Supervisor.start_link(children, strategy: :one_for_one)

    # deprecated way
    # import Supervisor.Spec
    #
    # children = [
    #   worker(Dictionary.WordList, [])
    # ]
    #
    # options = [
    #   name: Dictionary.Supervisor,
    #   strategy: :one_for_one
    # ]
    #
    # Supervisor.start_link(children, options)
  end
end
