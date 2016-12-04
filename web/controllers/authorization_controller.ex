defmodule Lunatube.AuthorizationController do
  use Lunatube.Web, :controller
  alias Lunatube.User

  def login_with_poniverse(conn, %{"code" => code}) do
    client = Poniverse.get_token!(code: code)

    poniverse_user = OAuth2.Client.get!(client, "/users/me").body

    user = User.get_or_insert(poniverse_user)

    new_conn = Guardian.Plug.api_sign_in(conn, user)
    jwt = Guardian.Plug.current_token(new_conn)
    {:ok, claims} = Guardian.Plug.claims(new_conn)
    exp = Map.get(claims, "exp")

    new_conn
    |> put_resp_header("authorization", "Bearer #{jwt}")
    |> put_resp_header("x-expires", "#{exp}")
    |> json(%{user: user, jwt: jwt, exp: exp})
  end
end
