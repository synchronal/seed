defmodule Core.Repo do
  use Ecto.Repo,
    otp_app: :seed,
    adapter: Ecto.Adapters.Postgres
end
