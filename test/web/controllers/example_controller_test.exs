defmodule Web.ExampleControllerTest do
  # @related [subject](lib/web/controllers/example_controller.ex)
  
  use Test.ConnCase

  test "GET /example", %{conn: conn} do
    conn = get(conn, ~p"/example")
    assert html_response(conn, 200) =~ "Example"
  end
end
