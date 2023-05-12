defmodule Test do
  @moduledoc """
  Root module for test support files. Tests themselves should be in the root module of the module they are testing
  (the test of `Core.Foo` should be `Core.FooTest`, not `Test.FooTest`).
  """

  use Boundary, deps: [Core, Web], exports: []
end
