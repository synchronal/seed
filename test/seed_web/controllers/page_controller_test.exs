defmodule Web.PageControllerTest do
  use Web.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "hello"
  end
end
