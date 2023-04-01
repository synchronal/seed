defmodule Test.Page do
  import Moar.Assertions
  alias HtmlQuery, as: Hq

  @spec assert_here(Pages.Driver.t(), binary() | atom()) :: Pages.Driver.t()
  def assert_here(page, page_id),
    do: page |> Hq.find("[test-page]") |> Hq.attr("test-page") |> assert_eq(to_string(page_id), returning: page)
end
