defmodule Core.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      aliases: aliases(:app) ++ aliases(:seed),
      app: :seed,
      compilers: [:boundary] ++ Mix.compilers(),
      deps: deps(:app) ++ deps(:seed),
      dialyzer: dialyzer(),
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      version: @version
    ]
  end

  def application do
    [
      mod: {Core.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # # #

  defp aliases(:app) do
    []
  end

  defp aliases(:seed) do
    [
      setup: ["deps.get", "ecto.setup", "assets.setup", "assets.build"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      "assets.setup": ["esbuild.install --if-missing"],
      "assets.build": ["esbuild default"],
      "assets.deploy": ["esbuild default --minify", "sass default --no-source-map --style=compressed", "phx.digest"]
    ]
  end

  defp deps(:app) do
    []
  end

  defp deps(:seed) do
    [
      {:boundary, "~> 0.9.4", runtime: false},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:dart_sass, "~> 0.5"},
      {:dialyxir, "~> 1.1", only: [:dev, :test], runtime: false},
      {:ecto_sql, "~> 3.6"},
      {:esbuild, "~> 0.5", runtime: Mix.env() == :dev},
      {:finch, "~> 0.13"},
      {:floki, ">= 0.30.0", only: :test},
      {:gettext, "~> 0.20"},
      {:jason, "~> 1.2"},
      {:markdown_formatter, "~> 0.1", only: [:dev, :test], runtime: false},
      {:mix_audit, "~> 2.1", only: [:dev], runtime: false},
      {:mix_test_interactive, "~> 1.2", only: :dev, runtime: false},
      {:moar, "~> 1.36"},
      {:pages, "~> 0.11", only: :test},
      {:phoenix, "~> 1.7.1"},
      {:phoenix_ecto, "~> 4.4"},
      {:phoenix_html, "~> 3.3"},
      {:phoenix_live_dashboard, "~> 0.8"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_view, "~> 0.19"},
      {:plug_cowboy, "~> 2.5"},
      {:postgrex, ">= 0.0.0"},
      {:schema_assertions, "~> 0.1", only: [:dev, :test]},
      {:sobelow, "~> 0.12", only: [:dev, :test], runtime: false},
      {:swoosh, "~> 1.3"},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"}
    ]
  end

  def dialyzer do
    [
      plt_add_apps: [:ex_unit, :mix],
      plt_add_deps: :app_tree,
      plt_file: {:no_warn, "priv/plts/dialyzer.plt"}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
