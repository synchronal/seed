defmodule Web.Live.Home do
  use Web, :live_view

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    Home
    """
  end

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    socket
    |> assign(page_id: "home")
    |> ok()
  end
end
