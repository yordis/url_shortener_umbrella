defmodule Umbrella.MixProject do
  use Mix.Project

  @app :umbrella
  @version "0.1.0"
  @elixir_version "~> 1.14"
  @source_url " https://github.com/yordis/url_shortener_umbrella"

  def project do
    [
      app: @app,
      version: @version,
      elixir: @elixir_version,
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      test_coverage: test_coverage(),
      preferred_cli_env: preferred_cli_env(),
      docs: docs(),
      releases: releases()
    ]
  end

  def application do
    [
      mod: {Umbrella.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  defp test_coverage do
    [tool: ExCoveralls]
  end

  defp preferred_cli_env do
    [
      coveralls: :test,
      "coveralls.html": :test,
      "test.ecto.reset": :test
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:phoenix, "~> 1.7.9"},
      {:phoenix_ecto, "~> 4.4"},
      {:ecto_sql, "~> 3.10"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 3.3"},
      {:phoenix_live_view, "~> 0.20.1"},
      {:phoenix_live_dashboard, "~> 0.8.2"},
      {:swoosh, "~> 1.3"},
      {:finch, "~> 0.13"},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"},
      {:gettext, "~> 0.20"},
      {:jason, "~> 1.2"},
      {:dns_cluster, "~> 0.1.1"},
      {:plug_cowboy, "~> 2.5"},
      {:csv, "~> 3.2"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:esbuild, "~> 0.7", runtime: Mix.env() == :dev},
      {:tailwind, "~> 0.2.0", runtime: Mix.env() == :dev},
      {:floki, ">= 0.30.0", only: :test},
      {:excoveralls, "~> 0.18", only: :test},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp aliases do
    [
      setup: ["deps.get", "ecto.setup", "assets.setup", "assets.build"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      "test.ecto.reset": ["ecto.drop", "ecto.setup"],
      "assets.setup": ["tailwind.install --if-missing", "esbuild.install --if-missing"],
      "assets.build": ["tailwind default", "esbuild default"],
      "assets.deploy": ["tailwind default --minify", "esbuild default --minify", "phx.digest"]
    ]
  end

  defp docs do
    [
      main: "readme",
      homepage_url: @source_url,
      extras:
        [
          "README.md",
          "CONTRIBUTING.md"
        ] ++ Path.wildcard("./docs/*.md"),
      formatters: ["html"],
      source_ref: @source_url,
      groups_for_modules: [
        Infra: [
          Umbrella,
          Umbrella.Release,
          Umbrella.Mailer,
          Umbrella.Repo
        ],
        Web: [
          UmbrellaWeb.Endpoint,
          UmbrellaWeb,
          UmbrellaWeb.Gettext,
          UmbrellaWeb.Router,
          UmbrellaWeb.ErrorHTML,
          UmbrellaWeb.ErrorJSON,
          UmbrellaWeb.CoreComponents,
          UmbrellaWeb.Layouts,
          UmbrellaWeb.Telemetry
        ],
        "Links Context": [
          Umbrella.Links,
          Umbrella.Links.Link,
          ~r/UmbrellaWeb.Link/
        ]
      ]
    ]
  end

  defp releases do
    [
      umbrella: [
        applications: [umbrella: :permanent],
        version: release_version()
      ]
    ]
  end

  defp release_version do
    case System.get_env("COMMIT_SHORT_SHA") do
      nil -> @version
      commit_sha -> commit_sha
    end
  end
end
