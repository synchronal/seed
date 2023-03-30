defmodule Web.StatusControllerTest do
  # @related [subject](lib/web/controllers/status_controller.ex)

  use Test.ConnCase

  test "GET /status", %{conn: conn} do
    conn
    |> Pages.new()
    |> Test.Pages.StatusController.visit()
    |> Test.Pages.StatusController.assert_here()
  end
end
