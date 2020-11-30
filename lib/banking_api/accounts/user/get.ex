defmodule BankingApi.Accounts.User.Get do
  alias BankingApi.{Repo, Accounts.User}
  @moduledoc false
  @regex_cpf ~r/[0-9]{11}/

  @spec call(String.t()) :: {:ok, Ecto.Schema.t()} | {:error, String.t()}
  def call(cpf) when is_binary(cpf) do
    case String.match?(cpf, @regex_cpf) do
      true -> get(cpf)
      false -> {:error, "Invalid CPF format!"}
    end
  end

  def call(_), do: {:error, "Invalid CPF format!"}

  defp get(cpf) do
    Repo.get_by(User, cpf: cpf)
    |> create_response()
  end

  defp create_response(nil), do: {:error, "User not found!"}
  defp create_response(user), do: {:ok, user}
end
