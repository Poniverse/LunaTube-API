defmodule Lunatube.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :poniverse_id, :integer

      timestamps()
    end

    create index(:users, [:name], unique: true)
    create index(:users, [:email], unique: true)
  end
end
