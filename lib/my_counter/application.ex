defmodule MyCounter.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    Node.connect(:genserver@localhost)

    children = [
      MyCounterWeb.Telemetry,
      ## MyCounter.Repo,
      {DNSCluster, query: Application.get_env(:my_counter, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: MyCounter.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: MyCounter.Finch},
      # Start a worker by calling: MyCounter.Worker.start_link(arg)
      # {MyCounter.Worker, arg},
      # Start to serve requests, typically the last entry
      MyCounterWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MyCounter.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MyCounterWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
