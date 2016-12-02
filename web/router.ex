defmodule Lunatube.Router do
  use Lunatube.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Lunatube do
    pipe_through :api
  end
end
