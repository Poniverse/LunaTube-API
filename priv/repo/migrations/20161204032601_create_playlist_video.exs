defmodule Lunatube.Repo.Migrations.CreatePlaylistVideo do
  use Ecto.Migration

  def change do
    create table(:playlist_videos) do
      add :type, :string, null: false
      add :url, :string, null: false
      add :playlist_id, references(:playlists, on_delete: :nothing), null: false
      add :creator_id, references(:users, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:playlist_videos, [:playlist_id])
    create index(:playlist_videos, [:creator_id])
  end
end
