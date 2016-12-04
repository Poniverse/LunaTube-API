defmodule Lunatube.PlaylistVideo do
  use Lunatube.Web, :model

  schema "playlist_videos" do
    field :type, :string
    field :url, :string
    belongs_to :playlist, Lunatube.Playlist
    belongs_to :creator, Lunatube.Creator

    timestamps()
  end

  @doc """
  Builds a changeset based on the `playlist_video` and `params`.
  """
  def changeset(playlist_video, params \\ %{}) do
    playlist_video
    |> cast(params, [:type, :url, :playlist_id, :creator_id])
    |> validate_required([:type, :url, :playlist_id, :creator_id])
    |> assoc_constraint(:playlist)
    |> assoc_constraint(:creator)
  end
end
