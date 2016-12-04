defmodule Lunatube.Room do
  use Lunatube.Web, :model

  schema "rooms" do
    field :name, :string
    field :last_state_at, Ecto.DateTime
    field :last_state_offset, :integer
    belongs_to :owner, Lunatube.Owner

    timestamps()
  end

  @doc """
  Builds a changeset based on the `room` and `params`.
  """
  def changeset(room, params \\ %{}) do
    room
    |> cast(params, [:name, :last_state_at, :last_state_offset, :owner_id])
    |> cast_assoc(:owner)
    |> validate_required([:name, :last_state_at, :last_state_offset])
    |> assoc_constraint(:owner)
    |> unique_constraint(:name)
  end
end
