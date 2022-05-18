defmodule Queue do
  use GenServer

  def start_link(), do: GenServer.start_link(__MODULE__, :ok)

  def enqueue(pid, val) do
    GenServer.cast(pid, {:enq, val})
  end

  def dequeue(pid) do
    GenServer.call(pid, :deq)
  end


  @impl true
  def init(:ok) do
    {:ok, [1, 2, 3]}
  end

  @impl true
  def handle_call(:deq, _from, [head | tail]) do
    {:reply, head, tail}
  end

  @impl true
  def handle_cast({:enq, val}, arr) do
    {:noreply, arr++[val]}
  end
end
