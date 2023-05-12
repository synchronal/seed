defmodule Core.MetricsTest do
  # @related [subject](lib/core/metrics.ex)
  use Test.SimpleCase

  describe "status" do
    test "returns :ok always" do
      assert Core.Metrics.status() == :ok
    end
  end

  describe "visits" do
    test "returns a random number that's greater than or equal to 10" do
      1..1000
      |> Enum.map(fn _ -> Core.Metrics.visits() end)
      |> Enum.reject(fn count -> count >= 10 end)
      |> assert_eq([])
    end
  end
end
