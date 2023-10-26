import Config

config :umbrella,
  ecto_repos: [Umbrella.Repo],
  generators: [timestamp_type: :utc_datetime, binary_id: true]

config :umbrella, UmbrellaWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Phoenix.Endpoint.Cowboy2Adapter,
  render_errors: [
    formats: [html: UmbrellaWeb.ErrorHTML, json: UmbrellaWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Umbrella.PubSub,
  live_view: [signing_salt: "CAH6xeUY"]

config :umbrella, Umbrella.Mailer, adapter: Swoosh.Adapters.Local

config :esbuild,
  version: "0.17.11",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

config :tailwind,
  version: "3.3.2",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{config_env()}.exs"
