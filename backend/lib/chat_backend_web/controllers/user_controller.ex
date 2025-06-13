defmodule ChatBackendWeb.UserController do
  use ChatBackendWeb, :controller

  alias ChatBackend.Users
  alias ChatBackend.Users.User

  action_fallback ChatBackendWeb.FallbackController

  def index(conn, _params) do
    users = Users.list_users()
    render(conn, :index, users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Users.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/users/#{user}")
      |> render(:show, user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Users.get_user!(id)
    render(conn, :show, user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Users.get_user!(id)

    with {:ok, %User{} = user} <- Users.update_user(user, user_params) do
      render(conn, :show, user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Users.get_user!(id)

    with {:ok, %User{}} <- Users.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def try_login(conn, %{"username" => username, "password_hash" => password_hash}) do
    if (Users.try_login_user(username, password_hash)) do
      conn
      |> put_status(:ok)
      |> json(%{message: "Login successful"})
    else
      conn
      |> put_status(:unauthorized)
      |> json(%{error: "Invalid username or password"})
    end
  end
end
