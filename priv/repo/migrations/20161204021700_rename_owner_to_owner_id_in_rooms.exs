defmodule Lunatube.Repo.Migrations.RenameOwnerToOwnerIdInRooms do
  use Ecto.Migration

  def change do
    rename table(:rooms), :owner, to: :owner_id
  end
end
