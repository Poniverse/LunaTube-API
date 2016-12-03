defmodule Lunatube.Repo.Migrations.CreateRoom do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :name, :string, null: false
      add :last_state_at, :datetime
      add :last_state_offset, :integer
      add :owner, references(:users, on_delete: :nilify_all)

      timestamps()
    end

    create index(:rooms, [:name], unique: true)
    create index(:rooms, [:owner])
  end
end
