defmodule BankingApiWeb.UserController do
  use BankingApiWeb, :controller

  alias BankingApi.{Accounts, Accounts.User}

  action_fallback BankingApiWeb.FallbackController

  def index(conn, _params) do
    with {:ok, users} <- Accounts.list_users() do
      conn
      |> put_status(:ok)
      |> render("index.json", users: users)
    end
  end

  def create(conn, params) do
    with {:ok, user} <- Accounts.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, user} <- Accounts.get_user!(id) do
      conn
      |> put_status(:ok)
      |> render("show.json", user: user)
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
