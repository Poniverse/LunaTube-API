defmodule Lunatube.UserSocket do
  use Phoenix.Socket
  require Logger
  import  Guardian.Phoenix.Socket

  ## Channels
  channel "room:*", Lunatube.RoomChannel

  ## Transports
  transport :websocket, Phoenix.Transports.WebSocket
  # transport :longpoll, Phoenix.Transports.LongPoll

  # Socket params are passed from the client and can
  # be used to verify and authenticate a user. After
  # verification, you can put default assigns into
  # the socket that will be set for all channels, ie
  #
  #     {:ok, assign(socket, :user_id, verified_user_id)}
  #
  # To deny connection, return `:error`.
  #
  # See `Phoenix.Token` documentation for examples in
  # performing token verification on connect.
  def connect(%{"token" => jwt}, socket) do
    case sign_in(socket, jwt) do
      {:ok, authed_socket, guardian_params} ->
        authed_socket = authed_socket
        |> set_current_user(guardian_params[:resource])

        {:ok, authed_socket}
      _ ->
        #unauthenticated socket
        {:ok, socket}
    end
  end

  def connect(_params, socket) do
    {:ok, socket |> set_current_user(nil)}
  end

  # Socket id's are topics that allow you to identify all sockets for a given user:
  #
  #     def id(socket), do: "users_socket:#{socket.assigns.user_id}"
  #
  # Would allow you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given user:
  #
  #     Lunatube.Endpoint.broadcast("users_socket:#{user.id}", "disconnect", %{})
  #
  # Returning `nil` makes this socket anonymous.
  def id(%{assigns: %{user: %{id: id}}}), do: "users_socket:#{id}"
  def id(_), do: nil

  def set_current_user(socket, user) do
    assign(socket, :user, user);
  end
end
