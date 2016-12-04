defmodule Lunatube.PlaylistVideo do
  use Lunatube.Web, :model

  schema "playlist_videos" do
    field :type, :string
    field :url, :string
    belongs_to :playlist, Lunatube.Playlist, on_replace: :nilify
    belongs_to :creator, Lunatube.Creator, on_replace: :nilify

    timestamps()
  end

  @doc """
  Builds a changeset based on the `playlist_video` and `params`.
  """
  def changeset(playlist_video, params \\ %{}) do
    playlist_video
    |> cast(params, [:type, :url, :playlist_id, :creator_id])
    |> cast_assoc(:playlist, required: true)
    |> cast_assoc(:creator, required: true)
    |> validate_required([:type, :url])
    |> assoc_constraint(:playlist)
    |> assoc_constraint(:creator)
  end
end
