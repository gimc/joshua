use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :joshua, Joshua.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :joshua, Joshua.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "mysecretpassword",
  database: "joshua_test",
  hostname: "172.17.0.3",
  pool: Ecto.Adapters.SQL.Sandbox
