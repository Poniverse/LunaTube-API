defmodule Lunatube.RoomChannel.Monitor do
  @moduledoc """
  Channel monitor that updates current_time in state of a channel when it has a connected usersupervisor.ex.
  """

  use GenServer

  #####
  # External API


  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def get_all() do
    GenServer.call(__MODULE__, {:read})
  end

  def add_to_channel_connections_count(room_id) do
    GenServer.cast(__MODULE__, {:add, room_id})
  end

  def del_from_channel_connections_count(room_id) do
    GenServer.cast(__MODULE__, {:del, room_id})
  end

  #####
  # GenServer implementation

  def init(:ok) do
    {:ok, %{}}
  end

  def handle_call({:read}, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:add, room_id}, state) do
    count = case Map.get(state, room_id) do
      nil -> 1
      count -> count + 1
    end

    {:noreply, Map.put(state, room_id, count)}
  end

  def handle_cast({:del, room_id}, state) do
    count = case Map.get(state, room_id) do
      nil -> 0 # ??? (THAT'S UNPOSSIBLE ~ Ralph)
      count -> count - 1
    end

    case count > 0 do
      true -> {:noreply, Map.put(state, room_id, count)}
      false -> {:noreply, Map.delete(state, room_id)}
    end
  end
end
