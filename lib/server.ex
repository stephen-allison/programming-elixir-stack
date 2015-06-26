defmodule Stack.Server do
  use GenServer

  def start_link(initial_stack, name) do
    IO.puts "Starting Stack.Server with #{inspect initial_stack} name:#{name}"
    GenServer.start_link(__MODULE__, initial_stack, name: __MODULE__)
  end

  def push(value) do
    GenServer.cast __MODULE__, {:push, value}
  end

  def pop do
    GenServer.call __MODULE__, :pop
  end


  def handle_call(:pop, _from, current_stack) do
    case current_stack do
      [h|t] -> {:reply, h, t}
    end
  end

  def handle_cast({:push, value}, current_stack) do
    {:noreply, [value|current_stack]}
  end

end
