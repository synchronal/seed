defmodule Core.Metrics.VisitTest do
  # @related [subject](lib/core/metrics/visit.ex)
  use Test.DataCase, async: true

  test "schema" do
    assert_schema Core.Metrics.Visit, "visits",
      counter: :integer,
      date: :date,
      path: :string
  end
end
