defmodule BankingApi.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :password_hash, :string
      add :cpf, :string
      add :account_number, :integer
      add :balance, :integer

      timestamps()
    end

  end
end
