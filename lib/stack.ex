defmodule Stack do
  use Application

  def start(_type, _args) do
    IO.puts "Starting Stack application"
    {:ok, _pid} = Stack.Supervisor.start_link [3,2,1]
  end

end
