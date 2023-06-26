defmodule Core.Schema do
  # @related [test](/test/core/schema_test.exs)

  @type list_or_t_or_nil(type) :: [type] | type | nil

  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      @primary_key {:id, :binary_id, autogenerate: true}
      @foreign_key_type :binary_id
      @timestamp_opts [type: :utc_datetime_usec]
    end
  end

  @doc """
  When given a struct, returns the value of its `:id` key; otherwise returns the given value with the assumption
  that it is an ID.
  """
  @spec id(map() | struct() | binary()) :: binary()
  def id(%_{id: id}), do: id
  def id(%{id: id}), do: id
  def id(%{"id" => id}), do: id
  def id(id) when is_binary(id), do: id
  def id(other), do: raise("Expected a map or struct with `id` key or a binary, got: #{inspect(other)}")
end
