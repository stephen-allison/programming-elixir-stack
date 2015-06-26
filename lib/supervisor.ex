defmodule Stack.Supervisor do
  use Supervisor

  def start_link(initial_value) do
    IO.puts "Stack.Supervisor.start_link with #{inspect initial_value}"
    result = {:ok, sup} = Supervisor.start_link(__MODULE__, [initial_value])
    start_workers(sup, initial_value)
    result
  end

  def start_workers(sup, initial_value) do
    child = worker(Stack.Stash, [initial_value])
    {:ok, stash} = Supervisor.start_child(sup, child)

    subsup = supervisor(Stack.SubSupervisor, [stash])
    Supervisor.start_child(sup, subsup)
  end

  def init(_) do
    IO.puts "Stack.Supervisor.init"
    supervise [], strategy: :one_for_one
  end

end
