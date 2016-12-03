defmodule Lunatube.RoomTest do
  use Lunatube.ModelCase
  import Lunatube.Factory

  alias Lunatube.Room

  test "changeset with valid attributes" do
    changeset = Room.changeset(%Room{}, params_for(:room))
    assert changeset.valid?
  end

  test "changeset without a name" do
    changeset = Room.changeset(%Room{}, params_for(:room, name: false))
    refute changeset.valid?
  end

  test "changeset with a duplicate name" do
    room  = insert(:room)
    room2 = %Room{} |> Room.changeset(params_for(:room, name: room.name))

    assert {:error, changeset} = Repo.insert(room2)
    refute changeset.valid?
  end
end
