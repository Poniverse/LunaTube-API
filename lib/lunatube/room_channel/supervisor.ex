defmodule Lunatube.RoomChannel.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    children = [
      worker(Lunatube.RoomChannel.Monitor, [[name: Lunatube.RoomChannel.Monitor]])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
