defmodule Lunatube.ExternalUser do
  use Lunatube.Web, :model

  schema "external_users" do
    field :user_id, :integer
    field :external_user_id, :integer
    field :type, :string
    field :service, :string
    field :access_token, :string
    field :refresh_token, :string
    field :expires, Ecto.DateTime

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :external_user_id, :type, :service, :access_token, :refresh_token, :expires])
    |> validate_required([:user_id, :external_user_id, :type, :service, :access_token, :refresh_token, :expires])
  end
end
