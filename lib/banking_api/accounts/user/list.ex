defmodule BankingApi.Accounts.User.List do
  @moduledoc false
  alias BankingApi.{Repo, Accounts.User}

  @spec call :: {:ok, [Ecto.Schema.t()]}
  def call do
    Repo.all(User)
    |> list()
  end

  defp list(users), do: {:ok, users}
end
