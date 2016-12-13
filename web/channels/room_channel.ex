defmodule Lunatube.RoomChannel do
  use Lunatube.Web, :channel
  require Logger
  alias Lunatube.{Presence, Repo, Room, RoomChannel.Monitor}
  alias Ecto.Changeset

  def join("room:" <> room_id, payload, socket) do
    if authorized?(payload) do
      room_state = get_state(room_id)

      send(self, :after_join)
      {:ok, room_state, assign(socket, :room, room_id)}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def get_state(id) do
     Repo.get!(Room, id)
     |> create_default_state_if_empty
  end

  def create_default_state_if_empty(room) do
    case room.last_known_state do
      nil ->
        room = Changeset.change room, %{
          last_state_at: Timex.now,
          last_known_state: %{
            source: "youtube",
            url: "Qi69aTLYF8E",
            state: "playing",
            duration: 256,
            current_time: 0,
          }
        }

        Repo.update! room
      room -> room
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (room:lobby).

  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end

  def terminate(_reason, socket) do
    Monitor.del_from_channel_connections_count(socket.assigns.room)
    :ok
  end

  def handle_info(:after_join, socket) do
    Monitor.add_to_channel_connections_count(socket.assigns.room)

    push socket, "presence_state", Presence.list(socket)
    {:ok, _} = Presence.track(socket, socket.assigns.user.id, %{
      online_at: inspect(System.system_time(:seconds)),
      name: socket.assigns.user.name
    })
    {:noreply, socket}
  end


  #
  # TODO: Reset video state when current_timer reaches duration
  # Add a video_start_time to compare when diffing
  # When a "leader" pauses the video, it should unset that
  # When a "leader" resumes the video, it should set that and the current time based on the leaders
  # state
  # For now a "leader" is any user since we're not touching ACL right now
  # Sync (Simple!) Pause and seek times between clients and log them to the state
  #
end
