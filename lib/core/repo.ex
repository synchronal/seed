defmodule Core.Repo do
  use Ecto.Repo,
    otp_app: :seed,
    adapter: Ecto.Adapters.Postgres

  @doc "Returns `aggregate(:count)` for the `query`"
  @spec count(Ecto.Queryable.t()) :: term()
  def count(query),
    do: query |> aggregate(:count)

  @doc "Returns the sum of field `field` in `query`"
  @spec sum(Ecto.Queryable.t(), atom()) :: term()
  def sum(query, field),
    do: query |> Core.Repo.aggregate(:sum, field) || 0
end
