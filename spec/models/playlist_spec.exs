defmodule Lunatube.PlaylistSpec do
  use ESpec.Phoenix, model: Playlist, async: true
  alias Lunatube.Playlist

  it "has a valid factory" do
    changeset = Playlist.changeset(%Playlist{}, params_for(:playlist))
    expect(changeset.valid?).to be_true
  end

  it "is invalid without a name" do
    changeset = Playlist.changeset(%Playlist{}, params_for(:playlist, name: nil))
    expect(changeset.errors).to have({:name, {"can't be blank", []}})
  end
end
