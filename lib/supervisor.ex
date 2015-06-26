defmodule Stack.Supervisor do
  use Supervisor

  def start_link(initial_value) do
    result = {:ok, sup} = Supervisor.start_link(__MODULE__, [initial_value])
    start_workers(sup, initial_value)
    result
  end

  def start_workers(sup, initial_value) do
    {:ok, stash} = Supervisor.start_child(sup, initial_value)
    Supervisor.start_child(sup, supervisor(Stack.SubSupervisor, [stash]))
  end

  def init(_) do
    supervise [], strategy: :one_for_one
  end

end
