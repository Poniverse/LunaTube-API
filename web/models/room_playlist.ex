defmodule Lunatube.RoomPlaylist do
  use Lunatube.Web, :model

  schema "room_playlists" do
    belongs_to :room, Lunatube.Room, on_replace: :nilify
    belongs_to :playlist, Lunatube.Playlist, on_replace: :nilify

    timestamps()
  end

  @doc """
  Builds a changeset based on the `room_playlist` and `params`.
  """
  def changeset(room_playlist, params \\ %{}) do
    room_playlist
    |> cast(params, [:room_id, :playlist_id])
    |> cast_assoc(:room, required: true)
    |> cast_assoc(:playlist, required: true)
    |> assoc_constraint(:room)
    |> assoc_constraint(:playlist)
    |> unique_constraint(:duplicate_playlist,
         name: :index_on_room_and_playlist,
         message: "already exists in room")
  end
end
