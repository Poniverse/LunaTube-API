defmodule Lunatube.RoomChannel.Update do
  use GenServer
  use Timex

  alias Lunatube.{Repo, Room, RoomChannel.Monitor}
  alias Ecto.Changeset

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    schedule_work()
    {:ok, state}
  end

  def handle_info(:work, state) do
    Monitor.get_all()
    |> update_current_time

    schedule_work()
    {:noreply, state}
  end

  def update_current_time(rooms) do
    for room_id <- Map.keys(rooms) do
      room = Repo.get(Room, room_id)
      now = Timex.now
      diff = Timex.diff(now, room.last_state_at, :seconds)
      last_known_state = Map.put(room.last_known_state, "current_time", diff)

      room = Changeset.change room, %{
        last_known_state: last_known_state
      }

      Repo.update! room
    end
  end

  defp schedule_work() do
    Process.send_after(self(), :work, 1000) # In 2 hours
  end
end
