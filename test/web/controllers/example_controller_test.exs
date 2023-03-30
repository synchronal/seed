defmodule Web.ExampleControllerTest do
  use Web.ConnCase

  test "GET /example", %{conn: conn} do
    conn = get(conn, ~p"/example")
    assert html_response(conn, 200) =~ "Example"
  end
end
