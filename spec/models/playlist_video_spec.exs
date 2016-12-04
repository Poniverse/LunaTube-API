defmodule Lunatube.PlaylistVideoSpec do
  use ESpec.Phoenix, model: PlaylistVideo, async: true
  alias Lunatube.PlaylistVideo

  let :playlist_video do
    build :playlist_video
  end

  it "has a valid factory" do
    changeset = playlist_video |> PlaylistVideo.changeset
    expect(changeset.valid?).to be_true
  end

  it "is invalid without a type" do
    changeset = playlist_video |> PlaylistVideo.changeset(%{type: nil})
    expect(changeset.errors).to have({:type, {"can't be blank", []}})
  end

  it "is invalid without a url" do
    changeset = playlist_video |> PlaylistVideo.changeset(%{url: nil})
    expect(changeset.errors).to have({:url, {"can't be blank", []}})
  end

  it "is invalid without a playlist" do
    changeset = playlist_video |> PlaylistVideo.changeset(%{playlist: nil})
    expect(changeset.errors).to have({:playlist, {"can't be blank", []}})
  end

  it "is invalid without a creator" do
    changeset = playlist_video |> PlaylistVideo.changeset(%{creator: nil})
    expect(changeset.errors).to have({:creator, {"can't be blank", []}})
  end
end
