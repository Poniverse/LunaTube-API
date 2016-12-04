defmodule Lunatube.Factory do
  use ExMachina.Ecto, repo: Lunatube.Repo

  def room_factory do
    %Lunatube.Room{ name: "Test Room", last_state_at: Ecto.DateTime.utc, last_state_offset: 0 }
  end

  def with_owner(room) do
    %{ room | owner: build(:user) }
  end

  def user_factory do
    %Lunatube.User{ name: "Test", email: "test@poniverse.net", poniverse_id: 1 }
  end
end