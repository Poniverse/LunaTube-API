defmodule Lunatube do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      supervisor(Lunatube.Repo, []),
      # Start the endpoint when the application starts
      supervisor(Lunatube.Endpoint, []),
      supervisor(Lunatube.Presence, []),
      # Start your own worker by calling: Lunatube.Worker.start_link(arg1, arg2, arg3)
      # worker(Lunatube.Worker, [arg1, arg2, arg3]),
      supervisor(Lunatube.RoomChannel.Supervisor, []),
      worker(Lunatube.RoomChannel.Update, [])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Lunatube.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Lunatube.Endpoint.config_change(changed, removed)
    :ok
  end
end
