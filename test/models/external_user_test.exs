defmodule Lunatube.ExternalUserTest do
  use Lunatube.ModelCase

  alias Lunatube.ExternalUser

  @valid_attrs %{access_token: "some content", expires: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, external_user_id: 42, refresh_token: "some content", service: "some content", type: "some content", user_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ExternalUser.changeset(%ExternalUser{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ExternalUser.changeset(%ExternalUser{}, @invalid_attrs)
    refute changeset.valid?
  end
end
