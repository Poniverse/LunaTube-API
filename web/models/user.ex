defmodule Lunatube.User do
  use Lunatube.Web, :model

  @derive {Poison.Encoder, only: [:id, :name, :email]}

  schema "users" do
    field :name, :string
    field :email, :string
    field :poniverse_id, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `user` and `params`.
  """
  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:name, :email, :poniverse_id])
    |> validate_required([:name, :email, :poniverse_id])
  end
end
