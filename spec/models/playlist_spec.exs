defmodule Lunatube.PlaylistSpec do
  use ESpec.Phoenix, model: Playlist, async: true
  alias Lunatube.Playlist

  let :playlist do
    build :playlist
  end

  it "has a valid factory" do
    changeset = playlist |> Playlist.changeset
    expect(changeset.valid?).to be_true
  end

  it "is invalid without a name" do
    changeset = playlist |> Playlist.changeset(%{name: nil})
    expect(changeset.errors).to have({:name, {"can't be blank", []}})
  end
end
