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

  def find_by_service_and_user(query \\ %ExternalUser{}, service, user_id) do
    from u in query,
    where: u.service == ^service and u.external_user_id == ^user_id
  end

  def find_poniverse_user(query \\ %ExternalUser{}, poniverse_user_id) do
    find_by_service_and_user(query, "poniverse", poniverse_user_id)
  end
end
