defmodule Core.MetricsTest do
  # @related [subject](lib/core/metrics.ex)
  use Test.DataCase

  describe "record_visit!" do
    test "records a single visit" do
      assert_that Core.Metrics.record_visit!("/path/a"),
        changes: Core.Metrics.visits("/path/a"),
        from: 0,
        to: 1

      assert_that Core.Metrics.record_visit!("/path/b", 1),
        changes: Core.Metrics.visits("/path/b"),
        from: 0,
        to: 1
    end

    test "can optionally record multiple visits" do
      assert_that Core.Metrics.record_visit!("/path/c", 3),
        changes: Core.Metrics.visits("/path/c"),
        from: 0,
        to: 3
    end
  end

  describe "status" do
    test "returns :ok always" do
      assert Core.Metrics.status() == :ok
    end
  end

  describe "visits" do
    test "returns the current number of visits for all paths" do
      assert Core.Metrics.visits() == 0

      Core.Metrics.record_visit!("/path/a", 1)
      Core.Metrics.record_visit!("/path/b", 2)
      Core.Metrics.record_visit!("/path/c", 3)

      assert Core.Metrics.visits() == 6
    end

    test "returns the current number of visits for a given path" do
      Core.Metrics.record_visit!("/path/b", 2)

      assert Core.Metrics.visits("/path/a") == 0
      assert Core.Metrics.visits("/path/b") == 2
    end
  end
end
