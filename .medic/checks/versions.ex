defmodule Local.Checks.Versions do
  defmodule Asdf do
    @path ".tool-versions"

    def elixir,
      do: {@path, extract("elixir", "elixir"), "elixir"}

    def elixir_otp_major,
      do: {@path, extract("elixir", "otp"), "elixir-otp-major"}

    def erlang,
      do: {@path, extract("erlang"), "erlang"}

    def erlang_major do
      version = extract("erlang")
      [major | _rest] = String.split(version, ".")
      {@path, major, "erlang-major"}
    end

    # # #

    defp extract("elixir", part) when part in ~w[elixir otp] do
      ~r/^(?<elixir>\d+\.\d+\.\d+)-otp-(?<otp>\d+).*/
      |> Regex.named_captures(extract("elixir"))
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

  defmodule Dockerfile do
    @path "Dockerfile"

    def elixir,
      do: {@path, extract("ELIXIR_VERSION"), "elixir"}

    def erlang,
      do: {@path, extract("OTP_VERSION"), "erlang"}

    # # #

    defp extract(key) do
      ~r/ARG #{key}=(?<version>[\d\.]+)/
      |> Regex.named_captures(File.read!(@path))
      |> Map.get("version")
    end
  end

  defmodule GithubTests do
    @path ".github/workflows/tests.yml"

    def elixir,
      do: {@path, extract("ELIXIR_VERSION"), "elixir"}

    def erlang,
      do: {@path, extract("OTP_VERSION"), "erlang"}

    # # #

    defp extract(key) do
      @path
      |> File.read!()
      |> YamlElixir.read_from_string!()
      |> Map.get("env")
      |> Map.get(key)
    end
  end

  # # #

  def synchronized? do
    synchronized?([
      {Asdf.elixir(), Dockerfile.elixir()},
      {Asdf.elixir(), GithubTests.elixir()},
      {Asdf.elixir_otp_major(), Asdf.erlang_major()},
      {Asdf.erlang(), Dockerfile.erlang()},
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
