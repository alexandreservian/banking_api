defmodule BankingApi.Accounts.User.Delete do
  alias BankingApi.{Repo, Accounts}
  @moduledoc false

  @spec call(integer() | String.t()) ::
          {:ok, Ecto.Schema.t()} | {:error, String.t()}
  def call(id) do
    case Accounts.get_user!(id) do
      {:ok, user} -> delete(user)
      {:error, _reason} = error -> error
    end
  end

  defp delete(user), do: Repo.delete(user)
end
