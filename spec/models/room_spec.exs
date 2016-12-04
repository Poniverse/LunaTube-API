defmodule Lunatube.RoomSpec do
  use ESpec.Phoenix, model: User, async: true
  alias Lunatube.Room

  let :room do
    build :room
  end

  it "has a valid factory" do
    changeset = room |> Room.changeset
    expect(changeset.valid?).to be_true
  end

  it "is invalid without a name" do
    changeset = room |> Room.changeset(%{name: nil})
    expect(changeset.errors).to have({:name, {"can't be blank", []}})
  end

  context "when another room exists" do
    let :other_room do
      insert :room
    end

    it "is valid with a different name" do
      room = room |> Room.changeset(%{name: other_room.name <> "2"})
      expect Repo.insert(room) |> to(be_ok_result)
    end

    it "is invalid with the same name" do
      room = room |> Room.changeset(%{name: other_room.name})
      {:error, changeset} = Repo.insert(room) 

      expect(changeset.errors).to have({:name, {"has already been taken", []}})
    end
  end
end
