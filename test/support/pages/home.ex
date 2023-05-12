defmodule Test.Pages.Home do
  # @related [LiveView](lib/web/live/home_live.ex)

  import Moar.Assertions
  import ExUnit.Assertions
  alias HtmlQuery, as: Hq

  @spec assert_here(Pages.Driver.t()) :: Pages.Driver.t()
  def assert_here(page),
    do: page |> Test.Page.assert_here(:home)

  @spec assert_message(Pages.Driver.t(), binary()) :: Pages.Driver.t()
  def assert_message(page, expected_message),
    do: page |> Hq.find!(test_role: "message") |> Hq.text() |> assert_eq(expected_message, returning: page)

  @spec assert_visits(Pages.Driver.t(), atom(), integer()) :: Pages.Driver.t()
  def assert_visits(page, :gte, min_count) do
    count = page |> Hq.find!(test_role: "visits") |> Hq.text() |> String.to_integer()
    assert count >= min_count
    page
  end

  @spec visit(Pages.Driver.t()) :: Pages.Driver.t()
  def visit(page),
    do: page |> Pages.visit(Web.Paths.home())
end
