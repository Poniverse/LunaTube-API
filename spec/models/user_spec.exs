defmodule Lunatube.UserSpec do
  use ESpec.Phoenix, model: User, async: true
  alias Lunatube.User

  it "has a valid factory" do
    changeset = User.changeset(%User{}, params_for(:user))
    expect(changeset.valid?).to be_true
  end

  it "is invalid without a name" do
    changeset = User.changeset(%User{}, params_for(:user, name: nil))
    expect(changeset.errors).to have({:name, {"can't be blank", []}})
  end
end
