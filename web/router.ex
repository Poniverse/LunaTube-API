defmodule Lunatube.Router do
  use Lunatube.Web, :router

  pipeline :api do
    plug :accepts, ["json"]

    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  scope "/", Lunatube do
    pipe_through :api

    post "/auth/poniverse", AuthorizationController, :login_with_poniverse
  end
end
