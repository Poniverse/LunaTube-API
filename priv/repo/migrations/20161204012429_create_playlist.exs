defmodule Lunatube.Repo.Migrations.CreatePlaylist do
  use Ecto.Migration

  def change do
    create table(:playlists) do
      add :name, :string, null: false
      add :tracks_count, :integer, null: false, default: 0

      timestamps()
    end

    create index(:playlists, [:name], unique: true)
  end
end
