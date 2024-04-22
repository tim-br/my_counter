defmodule MyCounterWeb.Plugs.SubdomainExtractor do
  import Plug.Conn
  import Phoenix.LiveView

  def init(default), do: default

  def call(conn, _opts) do
    IO.puts("subdomain extractor")
    IO.puts("host #{conn.host}")
    ## IO.puts("conn #{inspect(conn)}")

    case Regex.run(~r/^([^.]+)\.counter\.nauths\.io$/, conn.host) do
      [_, subdomain] ->
        IO.puts("gets here #{subdomain}")
        # Plug.Conn.put_session(Plug.Conn.fetch_session(conn), :subdomain, subdomain)
        # assign(conn, :subdomain, subdomain)
        Plug.Conn.put_session(conn, :subdomain, subdomain)

      ## put_flash(:info, "You can't access that page")

      _ ->
        Plug.Conn.put_session(conn, :subdomain, "book")
    end

    ## Plug.Conn.put_session(conn, :subdomain, "book")
  end
end
