defmodule Lunatube.RoomPlaylistSpec do
  use ESpec.Phoenix, model: RoomPlaylist, async: true
  alias Lunatube.RoomPlaylist

  let :room_playlist do
    build :room_playlist
  end

  it "has a valid factory" do
    changeset = room_playlist |> RoomPlaylist.changeset
    expect(changeset.valid?).to be_true
  end

  it "is invalid without a room" do
    changeset = room_playlist |> RoomPlaylist.changeset(%{room: nil})
    expect(changeset.errors).to have({:room, {"can't be blank", []}})
  end

  it "is invalid without a playlist" do
    changeset = room_playlist |> RoomPlaylist.changeset(%{playlist: nil})
    expect(changeset.errors).to have({:playlist, {"can't be blank", []}})
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
      room_playlist = RoomPlaylist.changeset(%RoomPlaylist{room: room, playlist: playlist}, %{})
      {:error, changeset} = Repo.insert(room_playlist)

      expect(changeset.errors).to have({:duplicate_playlist, {"already exists in room", []}})
    end
  end
end
