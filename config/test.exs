import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :seed, Core.Repo,
  database: "seed_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  password: "postgres",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10,
  port: String.to_integer(System.get_env("PGPORT", "5432")),
  username: "postgres"

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :seed, Web.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "nhi83GrOMRlNzfDIVdW3kuD+OxHPVLD6tr5kgPL6VoYW9+nsxohacIkqP1Yg2ZNA",
  server: false

# In test we don't send emails.
config :seed, Core.Mailer, adapter: Swoosh.Adapters.Test

# # #

config :logger, level: :warning
config :pages, :phoenix_endpoint, Web.Endpoint
config :phoenix, :plug_init_mode, :runtime
config :swoosh, :api_client, false
