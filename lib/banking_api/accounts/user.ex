defmodule BankingApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @required_params [:cpf, :email, :name, :password]
  @regex_email ~r/^(\S+)@((?:(?:(?!-)[a-zA-Z0-9-]{1,62}[a-zA-Z0-9])\.)+[a-zA-Z0-9]{2,12})$/
  @regex_cpf ~r/[0-9]{11}/

  schema "users" do
    field :account_number, :integer
    field :balance, :integer, default: 100_000
    field :cpf, :string
    field :email, :string
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_params)
    |> validate_required(@required_params)
    |> validate_format(:cpf, @regex_cpf, message: "has invalid CPF. Example valid CPF: '02102325802'")
    |> unique_constraint(:cpf)
    |> validate_format(:email, @regex_email)
    |> unique_constraint(:email)
    |> validate_length(:password, min: 6)
    |> validate_format(:password, ~r/[0-9]+/, message: "Password must contain a number")
    |> validate_format(:password, ~r/[A-Z]+/, message: "Password must contain an upper-case letter")
    |> validate_format(:password, ~r/[a-z]+/, message: "Password must contain a lower-case letter")
    |> validate_format(:password, ~r/[#\!\?&@\$%^&*\(\)]+/, message: "Password must contain a symbol")
  end
end
