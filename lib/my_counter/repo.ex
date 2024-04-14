defmodule MyCounter.Repo do
  use Ecto.Repo,
    otp_app: :my_counter,
    adapter: Ecto.Adapters.Postgres
end
