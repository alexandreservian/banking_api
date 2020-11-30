defmodule BankingApi.Accounts.User.Delete do
  alias BankingApi.{Repo, Accounts}
  @moduledoc false

  @spec call(String.t()) ::
          {:ok, Ecto.Schema.t()} | {:error, String.t()}
  def call(cpf) do
    case Accounts.get_user!(cpf) do
      {:ok, user} -> delete(user)
      {:error, _reason} = error -> error
    end
  end

  defp delete(user), do: Repo.delete(user)
end
