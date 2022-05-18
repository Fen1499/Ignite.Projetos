defmodule Filaq do
 use Agent

  def start_link do
    Agent.start_link(fn -> [] end)
  end

  def enq(pid, value) do
    Agent.update(pid, fn arr -> arr++[value] end )
  end

  def deq(pid) do
    Agent.get_and_update(pid, fn [head | tail] -> {head, tail} end)
  end
end
