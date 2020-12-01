defmodule BankingApi.Accounts.User.Update do
  alias BankingApi.{Repo, Accounts, Accounts.User}
  @moduledoc false

  @typedoc """
      Representa os dados que podem ser modificados do usuário
  """
  @type params :: %{
          :id => integer() | String.t(),
          optional(:name) => String.t(),
          optional(:password) => String.t()
        }

  @spec call(params) ::
          {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()} | {:error, String.t()}
  def call(%{id: id} = params) do
    case Accounts.get_user!(id) do
      {:ok, user} -> update(user, params)
      {:error, _reason} = error -> error
    end
  end

  defp update(user, params) do
    user
    |> User.changeset(params)
    |> Repo.update()
  end
end
