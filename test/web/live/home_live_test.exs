defmodule Web.HomeLiveTest do
  # @related [subject](lib/web/live/home_live.ex)
  # @related [test page](test/support/pages/home.ex)

  use Test.ConnCase, async: true

  @tag page: :logged_out
  test "says 'hello world'", %{pages: %{logged_out: page}} do
    page
    |> Test.Pages.Home.visit()
    |> Test.Pages.Home.assert_here()
    |> Test.Pages.Home.assert_message("hello world!")
    |> Test.Pages.Home.assert_visits(:gte, 10)
  end
end
