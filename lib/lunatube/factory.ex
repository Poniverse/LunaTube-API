defmodule Lunatube.Factory do
  use ExMachina.Ecto, repo: Lunatube.Repo

  def playlist_factory do
    %Lunatube.Playlist{name: "Test Playlist"}
  end

  def with_videos(playlist, videos_count \\ 1) do
    %{playlist | videos: build_list(videos_count, :playlist_video)}
  end

  def playlist_video_factory do
    %Lunatube.PlaylistVideo{
      type:     "Test",
      url:      "test://test",
      playlist: build(:playlist),
      creator:  build(:user)
    }
  end

  def room_factory do
    %Lunatube.Room{name: "Test Room", last_state_at: Ecto.DateTime.utc, last_state_offset: 0}
  end

  def with_owner(room) do
    %{room | owner: build(:user)}
  end

  def room_playlist_factory do
    %Lunatube.RoomPlaylist{room: build(:room), playlist: build(:playlist)}
  end

  def user_factory do
    %Lunatube.User{name: "Test", email: "test@poniverse.net", poniverse_id: 1}
  end
end
