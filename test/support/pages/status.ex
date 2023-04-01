defmodule Test.Pages.Status do
  import Moar.Assertions
  alias HtmlQuery, as: Hq

  @spec assert_here(Pages.Driver.t()) :: Pages.Driver.t()
  def assert_here(page),
    do: page |> Hq.find("[test-page]") |> Hq.attr("test-page") |> assert_eq("status", returning: page)

  @spec visit(Pages.Driver.t()) :: Pages.Driver.t()
  def visit(page),
    do: page.conn |> Pages.Driver.Conn.new() |> Pages.visit(Web.Paths.status())
end
