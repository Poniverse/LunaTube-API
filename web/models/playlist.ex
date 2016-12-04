defmodule Lunatube.Playlist do
  use Lunatube.Web, :model

  schema "playlists" do
    field :name, :string
    field :tracks_count, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `playlist` and `params`.
  """
  def changeset(playlist, params \\ %{}) do
    playlist
    |> cast(params, [:name, :tracks_count])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
