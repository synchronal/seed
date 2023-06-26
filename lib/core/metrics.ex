defmodule Core.Metrics do
  # @related [test](test/core/metrics_test.exs)
  @moduledoc """
  System and usage metrics.
  """

  alias Core.Metrics.Visit

  @doc "Record `count` visits to `path` (`count` defaults to `1`)"
  @spec record_visit!(binary(), non_neg_integer()) :: Visit.t()
  def record_visit!(path, count \\ 1),
    do: Core.Repo.insert!(Visit.new(path, count), Visit.opts_for_upsert(count))

  @doc "Returns the status of the system. (Currently, always `:ok`)"
  @spec status() :: :ok
  def status,
    do: :ok

  @doc "Returns the total number of visits"
  @spec visits() :: non_neg_integer()
  def visits,
    do: Core.Repo.sum(Visit, :counter)

  @doc "Returns the total number of visits for `path`"
  @spec visits(binary()) :: non_neg_integer()
  def visits(path),
    do: Visit.Query.with_path(path) |> Core.Repo.sum(:counter)
end
