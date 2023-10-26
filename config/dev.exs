import Config

config :umbrella, Umbrella.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "umbrella_dev",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

config :umbrella, UmbrellaWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4000],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "PSg7bq3xxOabH9HHB3U8LOx3SWcKDw2yS0ia0nwm7LO8octBoH3Org9xFBuofvz/",
  watchers: [
    esbuild: {Esbuild, :install_and_run, [:default, ~w(--sourcemap=inline --watch)]},
    tailwind: {Tailwind, :install_and_run, [:default, ~w(--watch)]}
  ]

config :umbrella, UmbrellaWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/umbrella_web/(controllers|live|components)/.*(ex|heex)$"
    ]
  ]

config :umbrella, dev_routes: true

config :logger, :console, format: "[$level] $message\n"

config :phoenix, :stacktrace_depth, 20

config :phoenix, :plug_init_mode, :runtime

config :phoenix_live_view, :debug_heex_annotations, true

config :swoosh, :api_client, false
