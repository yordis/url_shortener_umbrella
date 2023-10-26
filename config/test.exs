import Config

config :umbrella, Umbrella.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "umbrella_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

config :umbrella, UmbrellaWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "94Qnoz3dur3n9lzRUBf6UEPFOrLKW8wBx+jT13WNbQSIksfUrRnY53t6ZZvIozqo",
  server: false

config :umbrella, Umbrella.Mailer, adapter: Swoosh.Adapters.Test

config :swoosh, :api_client, false

config :logger, level: :warning

config :phoenix, :plug_init_mode, :runtime

config :umbrella, :task_module, TestSupport.Task
