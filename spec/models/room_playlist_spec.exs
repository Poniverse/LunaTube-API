defmodule Lunatube.RoomPlaylistSpec do
  use ESpec.Phoenix, model: RoomPlaylist, async: true
  alias Lunatube.RoomPlaylist

  it "has a valid factory" do
    changeset = RoomPlaylist.changeset(%RoomPlaylist{}, params_with_assocs(:room_playlist))
    expect(changeset.valid?).to be_true
  end

  it "is invalid without a room" do
    changeset = RoomPlaylist.changeset(%RoomPlaylist{}, params_with_assocs(:room_playlist, room: nil))
    expect(changeset.errors).to have({:room_id, {"can't be blank", []}})
  end

  it "is invalid without a playlist" do
    changeset = RoomPlaylist.changeset(%RoomPlaylist{}, params_with_assocs(:room_playlist, playlist: nil))
    expect(changeset.errors).to have({:playlist_id, {"can't be blank", []}})
  end

  context "when a room-playlist already exists" do
    let :room do
      insert :room
    end

    let :playlist do
      insert :playlist
    end

    before do
      insert :room_playlist, room: room, playlist: playlist
    end

    it "is invalid if it's an identical room-playlist" do
      room_playlist = %RoomPlaylist{} |> RoomPlaylist.changeset(%{room_id: room.id, playlist_id: playlist.id})
      {:error, changeset} = Repo.insert(room_playlist)

      expect(changeset.errors).to have({:duplicate_playlist, {"already exists in room", []}})
    end
  end
end
