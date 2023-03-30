defmodule Web.ExampleController do
  use Web, :controller

  def index(conn, _params) do
    # Skip the default app layout.
    render(conn, :index, layout: false)
  end
end
