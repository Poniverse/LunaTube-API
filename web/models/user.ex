defmodule Lunatube.User do
  use Lunatube.Web, :model

  alias Lunatube.Repo

  @derive {Poison.Encoder, only: [:id, :name, :email]}

  schema "users" do
    field :name, :string
    field :email, :string
    field :poniverse_id, :integer

    timestamps()
  end

  def get_by_poniverse_id(id) do
    Repo.get_by(Lunatube.User, poniverse_id: id)
  end

  def from_poniverse_json(params) do
    %Lunatube.User{
        name: params["display_name"],
        email: params["email"],
        poniverse_id: String.to_integer(params["id"])
    }
  end

  def get_or_insert(params) do
    case Lunatube.User.get_by_poniverse_id(String.to_integer(params["id"])) do
      nil -> Repo.insert!(Lunatube.User.from_poniverse_json(params))
      user -> user
    end
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
