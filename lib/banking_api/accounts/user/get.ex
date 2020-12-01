defmodule BankingApi.Accounts.User.Get do
  @moduledoc false
  alias BankingApi.{Repo, Accounts.User}
  @only_number ~r/^[0-9]+$/

  @spec call(integer() | String.t()) :: {:ok, Ecto.Schema.t()} | {:error, String.t()}
  def call(id) when is_integer(id), do: get(id)

  def call(id) when is_binary(id) do
    case String.match?(id, @only_number) do
      true -> get(id)
      false -> {:error, "Invalid ID format!", :invalid_id_format}
    end
  end

  def call(_), do: {:error, "Invalid ID format!", :invalid_id_format}

  defp get(id) do
    Repo.get(User, id)
    |> create_response()
  end

  defp create_response(nil), do: {:error, "User not found!", :not_found}
  defp create_response(user), do: {:ok, user}
end
