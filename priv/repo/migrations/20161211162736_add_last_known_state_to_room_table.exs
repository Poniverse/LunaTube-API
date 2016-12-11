defmodule Lunatube.Repo.Migrations.AddLastKnownStateToRoomTable do
  use Ecto.Migration

  def change do
    alter table(:rooms) do
      add :last_known_state, :map
    end
  end
end
