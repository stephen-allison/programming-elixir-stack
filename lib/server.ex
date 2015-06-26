defmodule Stack.Server do
  use GenServer

  def start_link(stash_pid) do
    IO.puts "Starting Stack.Server with Stash #{inspect stash_pid}"
    GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)
  end

  def push(value) do
    GenServer.cast __MODULE__, {:push, value}
  end

  def pop do
    GenServer.call __MODULE__, :pop
  end

  def init(stash_pid) do
    current_stack = Stack.Stash.get_value stash_pid
    IO.puts "Stack.Server retreived state #{inspect current_stack}"
    {:ok, {current_stack, stash_pid}}
  end

  def terminate(_reason, {current_value, stash_pid}) do
    IO.puts "Stack.Server terminated with state #{inspect current_value}"
    Stack.Stash.save_value stash_pid, current_value
  end


  def handle_call(:pop, _from, {current_stack, stash_pid}) do
    case current_stack do
      [h|t] -> {:reply, h, {t, stash_pid}}
      #[] -> {:reply, nil, {[], stash_pid}}
    end
  end

  def handle_cast({:push, value}, {current_stack, stash_pid}) do
    {:noreply, {[value|current_stack], stash_pid}}
  end

end
