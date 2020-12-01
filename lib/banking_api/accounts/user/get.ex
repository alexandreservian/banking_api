defmodule BankingApi.Accounts.User.Get do
  alias BankingApi.{Repo, Accounts.User}
  @moduledoc false

  @spec call(integer()) :: {:ok, Ecto.Schema.t()} | {:error, String.t()}
  def call(id) when is_integer(id), do: get(id)

  def call(_), do: {:error, "Invalid ID format!"}

  defp get(id) do
    Repo.get(User, id)
    |> create_response()
  end

  defp create_response(nil), do: {:error, "User not found!"}
  defp create_response(user), do: {:ok, user}
end
