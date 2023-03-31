defmodule Local.Checks.Versions do
  defmodule Asdf do
    @path ".tool-versions"

    def elixir do
      version = extract("elixir", "elixir")
      {@path, version, "elixir"}
    end

    def elixir_otp_major do
      version = extract("elixir", "otp")
      {@path, version, "elixir-otp-major"}
    end

    def erlang do
      version = extract("erlang")
      {@path, version, "erlang"}
    end

    def erlang_major do
      version = extract("erlang")
      [major | _rest] = String.split(version, ".")
      {@path, major, "erlang-major"}
    end

    # # #

    defp extract("elixir", part) when part in ~w[elixir otp] do
      version = extract("elixir")

      ~r/^(?<elixir>\d+\.\d+\.\d+)-otp-(?<otp>\d+).*/
      |> Regex.named_captures(version)
      |> Map.get(part)
    end

    defp extract(key) do
      @path
      |> File.read!()
      |> String.split("\n", trim: true)
      |> Map.new(fn line ->
        [key, value] = String.split(line, " ", parts: 2)
        {key, value}
      end)
      |> Map.get(key)
    end
  end

  defmodule GithubTests do
    @path ".github/workflows/tests.yml"

    def elixir do
      version = extract("ELIXIR_VERSION")
      {@path, version, "elixir"}
    end

    def erlang do
      version = extract("OTP_VERSION")
      {@path, version, "erlang"}
    end

    # # #

    defp extract(key) do
      @path
      |> File.read!()
      |> YamlElixir.read_from_string!()
      |> Map.get("env")
      |> Map.get(key)
    end
  end

  def synchronized? do
    synchronized?([
      {Asdf.elixir(), GithubTests.elixir()},
      {Asdf.elixir_otp_major(), Asdf.erlang_major()},
      {Asdf.erlang(), GithubTests.erlang()}
    ])
  end

  def synchronized?([{left, right} | tail]) do
    case check_version(left, right) do
      :ok -> synchronized?(tail)
      error -> error
    end
  end

  def synchronized?([]) do
    :ok
  end

  # # #

  defp check_version({source1, value1, type1}, {source2, value2, type2}) do
    if compare_versions(value1, value2) == :eq do
      :ok
    else
      {
        :error,
        """
        Version mismatch:
        - #{type1} version in “#{source1}” is “#{value1}”
        - #{type2} version in “#{source2}” is “#{value2}”
        """,
        "# Check #{source1} and #{source2}."
      }
    end
  end

  defp compare_versions(left, right) do
    Version.compare(maybe_fix_version(left), maybe_fix_version(right))
  end

  defp maybe_fix_version(string) do
    parts = String.split(string, ".")
    normalized = parts ++ List.duplicate("0", 3 - length(parts))
    Enum.join(normalized, ".")
  end
end
