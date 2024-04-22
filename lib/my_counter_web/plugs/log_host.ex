defmodule MyCounterWeb.Plugs.LogHost do
  import Plug.Conn

  def init(options), do: options

  def call(conn, _options) do
    host = conn.host
    IO.puts("Received request on host: #{host}")
    IO.puts("Connection: #{inspect(conn.assigns)}")
    IO.inspect(conn.assigns, label: "After Subdomain Extraction")

    conn
  end
end
