defmodule Core.Metrics do
  # @related [test](test/core/metrics_test.exs)
  @moduledoc """
  System and usage metrics.
  """

  @doc "Returns the status of the system. (Currently, always `:ok`)"
  @spec status() :: :ok
  def status, do: :ok

  @doc "Returns the number of visits today. (Currently, a random number >= 10)"
  @spec visits() :: integer()
  def visits, do: Enum.random(10..1000)
end
