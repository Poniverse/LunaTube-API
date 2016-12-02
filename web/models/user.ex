defmodule Lunatube.User do
  use Lunatube.Web, :model

  schema "users" do
    field :username, :string
    field :display_name, :string
    field :email, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:username, :display_name, :email])
    |> validate_required([:username, :display_name, :email])
  end
end
