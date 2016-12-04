defmodule Lunatube.AuthorizationController do
  use Lunatube.Web, :controller
  alias Lunatube.User

  def login(conn, _params) do
    user = Repo.get!(User, 1)

    new_conn = Guardian.Plug.api_sign_in(conn, user)
    jwt = Guardian.Plug.current_token(new_conn)
    {ok, claims} = Guardian.Plug.claims(new_conn)
    exp = Map.get(claims, "exp")

    IO.inspect user

    new_conn
    |> put_resp_header("authorization", "Bearer #{jwt}")
    |> put_resp_header("x-expires", "#{exp}")
    |> json %{user: user, jwt: jwt, exp: exp}
  end
end
