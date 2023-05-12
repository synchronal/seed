defmodule Core do
  @moduledoc """
  Root module for application logic and data.
  """

  use Boundary, deps: [], exports: [Metrics]
end
