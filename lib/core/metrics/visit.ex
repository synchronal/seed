defmodule Core.Metrics.Visit do
  # @related [test](/test/core/metrics/visit_test.exs)
  @moduledoc """
  Counts the number of visits to the site per day. Intentionally doesn't capture any user info.
  Inspired by: https://dashbit.co/blog/homemade-analytics-with-ecto-and-elixir
  """

  use Core.Schema
  alias Core.Metrics.Visit.Query

  @type t() :: %__MODULE__{}

  @primary_key false
  schema "visits" do
    field :counter, :integer, default: 0
    field :date, :date, primary_key: true
    field :path, :string, primary_key: true
  end

  @doc "Returns a new `Visit` for today at `path` and counter `count`"
  @spec new(binary(), non_neg_integer()) :: t()
  def new(path, count),
    do: %__MODULE__{date: Date.utc_today(), path: path, counter: count}

  @spec opts_for_upsert(non_neg_integer()) :: keyword()
  def opts_for_upsert(count),
    do: [on_conflict: Query.upsert(count), conflict_target: [:date, :path]]

  defmodule Query do
    import Ecto.Query
    alias Core.Metrics.Visit

    def display_order(query \\ base()),
      do: query |> exclude(:order_by) |> order_by([visits: visits], asc: [visits.date, visits.path])

    def sum(query \\ base()),
      do: query |> select([visits: visits], sum(visits.counter))

    def upsert(count),
      do: from(visits in Visit, update: [inc: [counter: ^count]])

    def with_path(query \\ base(), path),
      do: query |> where([visits: visits], visits.path == ^path)

    defp base,
      do: from(_ in Visit, as: :visits) |> display_order()
  end
end
