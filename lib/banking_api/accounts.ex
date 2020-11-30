defmodule BankingApi.Accounts do
  @moduledoc """
  Define o contexto Accounts.
  """
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
          {:ok, %User{}} | {:error, Ecto.Changeset.t()}
  defdelegate create_user(params), to: User.Create, as: :call

  @doc """
  Retorna uma lista de usuários.

  ## Examples

      iex> list_users()
      {
        :ok,
        [
          %BankingApi.Accounts.User{
            __meta__: #Ecto.Schema.Metadata<:loaded, "users">,
            balance: 100000,
            cpf: "01122233304",
            email: "alexandreservian@gmail.com",
            id: 1,
            inserted_at: ~N[2020-11-29 00:16:13],
            name: "Alexandre Servian",
            password: nil,
            password_hash: "$2b$12$N8a3OTw..uHBO9u6haxT.edb5Y0nRBrxq4Vyrg4psSnMy9eRzCmvu",
            updated_at: ~N[2020-11-29 00:16:13]
          }
        ]
      }

  """
  @spec list_users :: {:ok, [%User{}]}
  defdelegate list_users(), to: User.List, as: :call

  @doc """
  Returna somente um usuário a partir de um cpf existente e válido.

  ## Parameters

      - cpf: String de um cpf válido. Ex: "01122233304"

  ## Examples

      iex> get_user!("01122233304")
      {
        :ok,
        %BankingApi.Accounts.User{
          __meta__: #Ecto.Schema.Metadata<:loaded, "users">,
          balance: 100000,
          cpf: "01122233304",
          email: "alexandreservian@gmail.com",
          id: 1,
          inserted_at: ~N[2020-11-29 00:16:13],
          name: "Alexandre Servian",
          password: nil,
          password_hash: "$2b$12$N8a3OTw..uHBO9u6haxT.edb5Y0nRBrxq4Vyrg4psSnMy9eRzCmvu",
          updated_at: ~N[2020-11-29 00:16:13]
        }
      }

      iex> get_user!("13122233305")
      {:error, "User not found!"}

      iex> get_user!(01122233304)
      {:error, "Invalid CPF format!"}

      iex> get_user!("011.222.333-04")
      {:error, "Invalid CPF format!"}

  """
  @spec get_user!(String.t()) :: {:ok, %User{}} | {:error, String.t()}
  defdelegate get_user!(cpf), to: User.Get, as: :call

  @doc """
  Atualiza um usuário. O usuário só pode atualizar seu nome e seu password se necessário.

  ## Parameters

    - params: Map contendo os dados inicias do usuário. Examplo: %{cpf: "01122233304", name: "Servian", password: "Cc5_555"}

  ## Examples

      iex> update_user(%{cpf: "01122233304", name: "Servian"})
      {
        :ok,
        %BankingApi.Accounts.User{
          __meta__: #Ecto.Schema.Metadata<:loaded, "users">,
          balance: 100000,
          cpf: "01122233304",
          email: "alexandreservian@gmail.com",
          id: 1,
          inserted_at: ~N[2020-11-29 00:16:13],
          name: "Servian",
          password: nil,
          password_hash: "$2b$12$N8a3OTw..uHBO9u6haxT.edb5Y0nRBrxq4Vyrg4psSnMy9eRzCmvu",
          updated_at: ~N[2020-11-29 00:16:13]
        }
      }

      iex> update_user(%{cpf: "01122233304", name: ""})
      {:error,
        #Ecto.Changeset<
          action: :update,
          changes: %{},
          errors: [
            name: {"can't be blank", [validation: :required]},
          ],
          data: #BankingApi.Accounts.User<>,
          valid?: false
        >
      }

      iex> update_user(%{cpf: "13122233305", name: "Servian"})
      {:error, "User not found!"}

      iex> update_user(%{cpf: 01122233304, name: "Servian"})
      {:error, "Invalid CPF format!"}

      iex> update_user(%{cpf: "011.222.333-04", name: "Servian"})
      {:error, "Invalid CPF format!"}

  """
  @spec update_user(%{:cpf => binary, optional(:name) => binary, optional(:password) => binary}) ::
          {:ok, %User{}} | {:error, Ecto.Changeset.t()} | {:error, String.t()}
  defdelegate update_user(params), to: User.Update, as: :call

  @doc """
  Deleta um usuário.

  ## Parameters

    - cpf: String de um cpf válido. Ex: "01122233304"

  ## Examples

      iex> delete_user("01122233304")
      {
        :ok,
        %BankingApi.Accounts.User{
          __meta__: #Ecto.Schema.Metadata<:loaded, "users">,
          balance: 100000,
          cpf: "01122233304",
          email: "alexandreservian@gmail.com",
          id: 1,
          inserted_at: ~N[2020-11-29 00:16:13],
          name: "Alexandre Servian",
          password: nil,
          password_hash: "$2b$12$N8a3OTw..uHBO9u6haxT.edb5Y0nRBrxq4Vyrg4psSnMy9eRzCmvu",
          updated_at: ~N[2020-11-29 00:16:13]
        }
      }

      iex> delete_user("01122233304")
      {:error, "User not found!"}

      iex> delete_user("13122233305")
      {:error, "User not found!"}

      iex> delete_user(01122233304)
      {:error, "Invalid CPF format!"}

      iex> delete_user("011.222.333-04")
      {:error, "Invalid CPF format!"}

  """
  @spec delete_user(String.t()) ::
          {:ok, %User{}} | {:error, String.t()}
  defdelegate delete_user(cpf), to: User.Delete, as: :call
end
