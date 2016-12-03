defmodule Lunatube.RoomSpec do
  use ESpec.Phoenix, model: User, async: true
  alias Lunatube.Room

  it "has a valid factory" do
    changeset = Room.changeset(%Room{}, params_for(:room))
    expect(changeset.valid?).to be_true
  end

  it "is invalid without a name" do
    changeset = Room.changeset(%Room{}, params_for(:room, name: nil))
    expect(changeset.errors).to have({:name, {"can't be blank", []}})
  end

  context "when another room exists" do
    let :other do
      insert :room
    end

    it "is valid with a different name" do
      room = %Room{} |> Room.changeset(params_for(:room, name: other.name <> "2"))
      expect Repo.insert(room) |> to(be_ok_result)
    end

    it "is invalid with the same name" do
      room = %Room{} |> Room.changeset(params_for(:room, name: other.name))
      {:error, changeset} = Repo.insert(room) 

      expect(changeset.errors).to have({:name, {"has already been taken", []}})
    end
  end
end
