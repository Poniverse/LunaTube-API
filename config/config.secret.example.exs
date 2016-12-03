use Mix.Config

# In this file, we keep various configuration options
# that you likely want to automate and keep it away from
# your VCS repository such as database credentials,
# oauth keys.

# Poniverse Auth config
config :poniverse,
  client_id: "PONIVERSE_CLIENT_ID",
  client_secret: "PONIVERSE_CLIENT_SECRET",
  redirect_uri: "REDIRECT_URI"