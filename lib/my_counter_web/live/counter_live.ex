defmodule MyCounterWeb.CounterLive do
  use Phoenix.LiveView

  def mount(_params, session, socket) do
    Phoenix.PubSub.subscribe(GlobalCounter.PubSub, "my_counter_server:update")
    subdomain = session["subdomain"] || "default"
    init_value = GenServer.call({:global, String.to_atom(subdomain)}, :get_value)
    {:ok, assign(socket, %{count: init_value, subdomain: subdomain})}
  end

  def handle_event("add", _params, socket) do
    ## MyCounterServer.add()
    GenServer.cast({:global, String.to_atom(socket.assigns.subdomain)}, :add)
    {:noreply, assign(socket, :count, socket.assigns.count)}
  end

  def handle_event("subtract", _params, socket) do
    GenServer.cast({:global, String.to_atom(socket.assigns.subdomain)}, :subtract)
    {:noreply, assign(socket, :count, socket.assigns.count)}
  end

  @impl true
  def handle_info(update, socket) do
    {:noreply, assign(socket, :count, update)}
  end
end
