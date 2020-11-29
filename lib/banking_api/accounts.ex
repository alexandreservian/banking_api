defmodule BankingApi.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias BankingApi.Repo
  alias BankingApi.Accounts.User

  @doc """
  Cria um usuário.

  ## Parameters

    - params: Map contendo os dados inicias do usuário. Examplo: %{name: "Alexandre Servian", email: "alexandreservian@gmail.com", cpf: "01122233304", password: "Cc5_555"}

  ## Examples

      iex> params = %{name: "Alexandre Servian", email: "alexandreservian@gmail.com", cpf: "01122233304", password: "Cc5_555"}
      iex> create_user(params)
      {:ok,
        %BankingApi.Accounts.User{
        __meta__: #Ecto.Schema.Metadata<:loaded, "users">,
        balance: 100000,
        cpf: "01122233304",
        email: "alexandreservian@gmail.com",
        id: 1,
        inserted_at: ~N[2020-11-29 00:16:13],
        name: "Alexandre Servian",
        password: "Cc5_555",
        password_hash: "$2b$12$N8a3OTw..uHBO9u6haxT.edb5Y0nRBrxq4Vyrg4psSnMy9eRzCmvu",
        updated_at: ~N[2020-11-29 00:16:13]
      }}

      iex> create_user(%{})
      {:error,
        #Ecto.Changeset<
          action: :insert,
          changes: %{},
          errors: [
            cpf: {"can't be blank", [validation: :required]},
            email: {"can't be blank", [validation: :required]},
            name: {"can't be blank", [validation: :required]},
            password: {"can't be blank", [validation: :required]}
          ],
          data: #BankingApi.Accounts.User<>,
          valid?: false
        >
      }

  """
  @spec create_user(%{cpf: binary, email: binary, name: binary, password: binary}) ::
          {:error, Ecto.Changeset.t()} | {:ok, %{optional(atom) => any}}
  defdelegate create_user(params), to: User.Create, as: :call

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
end
