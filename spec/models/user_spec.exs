defmodule Lunatube.UserSpec do
  use ESpec.Phoenix, model: User, async: true
  alias Lunatube.User

  let :user do
    build :user
  end

  it "has a valid factory" do
    changeset = user |> User.changeset
    expect(changeset.valid?).to be_true
  end

  it "is invalid without a name" do
    changeset = user |> User.changeset(%{name: nil})
    expect(changeset.errors).to have({:name, {"can't be blank", []}})
  end
end
