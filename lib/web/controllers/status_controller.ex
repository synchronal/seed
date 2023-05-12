defmodule Web.StatusController do
  # @related [test](/test/web/controllers/status_controller_test.exs)

  use Web, :controller

  def index(conn, _params) do
    # Skip the default app layout.
    render(conn, layout: false, status: Core.Metrics.status())
  end
end
