# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :update,
  ecto_repos: [Update.Repo]

# Configures the endpoint
config :update, UpdateWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "c7xs8071fzpnOvvf12KO9hEcvCB5ZI5k15DbaxGW7m39f19lVVOlW2iqOYiOzDE9",
  render_errors: [view: UpdateWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Update.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
