defmodule Local.Checks.Versions do
  def check(type: type, version: expected_version, in: locations) do
    paths = %{
      "asdf" => ".tool-versions",
      "dockerfile" => "Dockerfile",
      "github_tests" => ".github/workflows/tests.yml"
    }

    Enum.reduce_while(List.wrap(locations), :ok, fn location, :ok ->
      actual_version = parse(location, paths[location], type)

      cond do
        actual_version == nil ->
          {:halt, {:error, "No version found for ‘#{type}’ in ‘#{location}’", "# Check ‘#{paths[location]}’"}}

        Moar.Version.compare(expected_version, actual_version) == :eq ->
          {:cont, :ok}

        :else ->
          message = "Expected ‘#{type}’ in ‘#{location}’ to be ‘#{expected_version}’ but was ‘#{actual_version}’"
          {:halt, {:error, message, "# Check ‘#{paths[location]}’"}}
      end
    end)
  end

  # # #

  defp parse("asdf" = _location, path, type) when type in ["elixir", "otp"] do
    regex = ~r/^elixir (?<elixir>\d+\.\d+\.\d+)-otp-(?<otp>\d+)$/m
    path |> File.read!() |> Moar.Regex.named_capture(regex, type)
  end

  defp parse("asdf" = _location, path, type) do
    regex = ~r/^#{type} (?<version>[\d+\.]+)$/m
    path |> File.read!() |> Moar.Regex.named_capture(regex, "version")
  end

  defp parse("dockerfile" = location, path, "erlang" = _type),
    do: parse(location, path, "otp")

  defp parse("dockerfile" = _location, path, type) do
    regex = ~r/ARG #{String.upcase(type)}_VERSION=(?<version>[\d\.]+)/
    path |> File.read!() |> Moar.Regex.named_capture(regex, "version")
  end

  defp parse("github_tests" = location, path, "erlang" = _type),
    do: parse(location, path, "otp")

  defp parse("github_tests" = _location, path, type) do
    key = "#{String.upcase(type)}_VERSION"
    path |> File.read!() |> YamlElixir.read_from_string!() |> get_in(["env", key])
  end
end
