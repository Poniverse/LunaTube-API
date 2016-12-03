defmodule Lunatube.UserTest do
  use Lunatube.ModelCase

  alias Lunatube.User

  @valid_attrs %{email: "some content", name: "some content", poniverse_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
