defmodule BankingApi.Accounts.User.Create do
  alias BankingApi.{Repo, Accounts.User}
  @moduledoc false

  @typedoc """
      Representa os dados iniciais do usuario
  """
  @type params :: %{cpf: String.t(), email: String.t(), name: String.t(), password: String.t()}

  @spec call(params) :: {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}
  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end
