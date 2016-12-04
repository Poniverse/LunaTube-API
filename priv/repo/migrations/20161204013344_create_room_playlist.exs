defmodule Lunatube.Repo.Migrations.CreateRoomPlaylist do
  use Ecto.Migration

  def change do
    create table(:room_playlists) do
      add :room_id, references(:rooms)
      add :playlist_id, references(:playlists)

      timestamps()
    end

    create index(:room_playlists, [:room_id])
    create index(:room_playlists, [:playlist_id])
    create index(:room_playlists, [:room_id, :playlist_id], unique: true, name: :index_on_room_and_playlist)
  end
end
