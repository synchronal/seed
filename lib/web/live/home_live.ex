defmodule Web.HomeLive do
  # @related [test](/test/web/live/home_live_test.exs)

  use Web, :live_view

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <div test-role="message">hello world!</div>
    """
  end

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    socket
    |> assign(page_id: "home")
    |> ok()
  end
end
