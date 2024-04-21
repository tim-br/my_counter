defmodule MyCounterWeb.CounterLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    Phoenix.PubSub.subscribe(GlobalCounter.PubSub, "my_counter_server:update")
    init_value = GenServer.call({:global, :global_counter}, :get_value)
    {:ok, assign(socket, :count, init_value)}
  end

  def handle_event("add", _params, socket) do
    ## MyCounterServer.add()
    GenServer.cast({:global, :global_counter}, :add)
    {:noreply, assign(socket, :count, socket.assigns.count)}
  end

  def handle_event("subtract", _params, socket) do
    GenServer.cast({:global, :global_counter}, :subtract)
    {:noreply, assign(socket, :count, socket.assigns.count)}
  end

  @impl true
  def handle_info(update, socket) do
    # Update the socket with the new information
    {:noreply, assign(socket, :count, update)}
  end
end
