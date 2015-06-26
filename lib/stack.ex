defmodule Stack do
  use Application

  def start(_type, _args) do
    IO.puts "Starting Stack application"
    import Supervisor.Spec, warn: false

    children = [
      worker(Stack.Server, [[1,2,3], :bob])
    ]

    opts = [strategy: :one_for_one, name: Stack.Supervisor]
    Supervisor.start_link(children, opts)
  end

end
