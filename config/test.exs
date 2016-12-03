use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :lunatube, Lunatube.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :lunatube, Lunatube.Repo,
  adapter: Ecto.Adapters.Postgres,
  hostname: "localhost",
  username: "poniverse",
  password: "secret",
  database: "app_test",
  pool: Ecto.Adapters.SQL.Sandbox
