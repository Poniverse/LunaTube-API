defmodule Lunatube.PlaylistVideoSpec do
  use ESpec.Phoenix, model: PlaylistVideo, async: true
  alias Lunatube.PlaylistVideo

  it "has a valid factory" do
    changeset = PlaylistVideo.changeset(%PlaylistVideo{}, params_with_assocs(:playlist_video))
    expect(changeset.valid?).to be_true
  end

  it "is invalid without a type" do
    changeset = PlaylistVideo.changeset(%PlaylistVideo{}, params_with_assocs(:playlist_video, type: nil))
    expect(changeset.errors).to have({:type, {"can't be blank", []}})
  end

  it "is invalid without a url" do
    changeset = PlaylistVideo.changeset(%PlaylistVideo{}, params_with_assocs(:playlist_video, url: nil))
    expect(changeset.errors).to have({:url, {"can't be blank", []}})
  end

  it "is invalid without a playlist" do
    changeset = PlaylistVideo.changeset(%PlaylistVideo{}, params_with_assocs(:playlist_video, playlist: nil))
    expect(changeset.errors).to have({:playlist_id, {"can't be blank", []}})
  end

  it "is invalid without a creator" do
    changeset = PlaylistVideo.changeset(%PlaylistVideo{}, params_with_assocs(:playlist_video, creator: nil))
    expect(changeset.errors).to have({:creator_id, {"can't be blank", []}})
  end
end
