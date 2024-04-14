defmodule MyCounterServer do
  use GenServer

  @name :counter_server

  def start_link(init_integer) when is_integer(init_integer) do
    GenServer.start_link(__MODULE__, init_integer, name: @name)
  end

  # def get_value(pid) do
  #   GenServer.call(pid, :get_value)
  # end
  def my_get_value() do
    GenServer.call(@name, :get_value)
  end

  def add() do
    GenServer.cast(@name, :add)
  end

  def subtract() do
    GenServer.cast(@name, :subtract)
  end

  @impl true
  def init(state) do
    IO.puts("FIXX")
    {:ok, state}
  end

  @impl true
  def handle_cast(:add, state) do
    # random_duration_ms = :rand.uniform(2000)
    # :timer.sleep(random_duration_ms)
    new_state = state + 1
    Phoenix.PubSub.broadcast(MyCounter.PubSub, "my_counter_server:update", new_state)
    {:noreply, new_state}
  end

  @impl true
  def handle_cast(:subtract, state) do
    new_state = state - 1
    Phoenix.PubSub.broadcast(MyCounter.PubSub, "my_counter_server:update", new_state)
    {:noreply, new_state}
  end

  @impl true
  def handle_call(:reset, _from, _state) do
    {:reply, :ok, 0}
  end

  def handle_call(:get_value, _from, state) do
    {:reply, state, state}
  end
end
