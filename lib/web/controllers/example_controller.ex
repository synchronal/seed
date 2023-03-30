defmodule Web.ExampleController do
  # @related [test](/test/web/controllers/example_controller_test.exs)
  
  use Web, :controller

  def index(conn, _params) do
    # Skip the default app layout.
    render(conn, :index, layout: false)
  end
end
