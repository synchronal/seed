defmodule Web.StatusControllerTest do
  # @related [subject](lib/web/controllers/status_controller.ex)

  use Test.ConnCase, async: true

  @tag page: :logged_out
  test "GET /status", %{pages: %{logged_out: page}} do
    page
    |> Test.Pages.Status.visit()
    |> Test.Pages.Status.assert_here()
  end
end
