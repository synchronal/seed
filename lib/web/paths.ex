defmodule Web.Paths do
  use Web, :verified_routes

  def status, do: ~p"/status"

  def static(path), do: static_path(Web.Endpoint, Path.join("/", path))
  def static(path, :url), do: static_url(Web.Endpoint, Path.join("/", path))
end
