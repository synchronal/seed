defmodule Web.HomeLive do
  # @related [test](/test/web/live/home_live_test.exs)

  use Web, :live_view

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <div test-role="message">hello world!</div>
    <div :if={@visits}>There have been <span test-role="visits"><%= @visits %></span> visits today.</div>
    """
  end

  @impl Phoenix.LiveView
  def mount(_params, _session, socket) do
    visits =
      if connected?(socket),
        do: Core.Metrics.visits(),
        else: nil

    socket
    |> assign(page_id: "home")
    |> assign(visits: visits)
    |> ok()
  end
end
