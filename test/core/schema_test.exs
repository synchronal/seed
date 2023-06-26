defmodule Core.SchemaTest do
  # @related [subject](/lib/core/schema.ex)

  defmodule SampleStruct do
    defstruct ~w[id]a
  end

  use Test.SimpleCase, async: true

  describe "id" do
    test "returns the id value when given a struct with an :id key" do
      assert Core.Schema.id(%SampleStruct{id: "1234"}) == "1234"
    end

    test "returns the id value when given a map with an :id key" do
      assert Core.Schema.id(%{id: "1234"}) == "1234"
      assert Core.Schema.id(%{"id" => "1234"}) == "1234"
    end

    test "returns the argument when given a binary" do
      assert Core.Schema.id("1234") == "1234"
    end

    test "raises when given something else" do
      assert_raise RuntimeError, "Expected a map or struct with `id` key or a binary, got: [:a, :b]", fn ->
        Core.Schema.id([:a, :b])
      end
    end
  end
end
