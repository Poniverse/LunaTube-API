# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :lunatube,
  ecto_repos: [Lunatube.Repo]

# Configures the endpoint
config :lunatube, Lunatube.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "wsNsojZr/3MtccM5fUq1UIoNx4wjpaHNzyOFNQsiMOJ+evr+xk0N/nUBS+QSYnwX",
  render_errors: [view: Lunatube.ErrorView, accepts: ~w(json)],
  pubsub: [name: Lunatube.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configures the tokens from Guardian
config :guardian, Guardian,
  allowed_algos: ["HS512"],
  verify_module: Guardian.JWT,
  issuer: "Lunatube",
  ttl: { 30, :days },
  verify_issuer: true,
  serializer: Lunatube.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

import_config "config.secret.exs"
