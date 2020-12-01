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
  get_user  Returna somente um usuário a partir de um id.

  ## Parameters

      - id: Integer

  ## Examples

      iex> get_user!(1)
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

      iex> get_user!(15)
      {:error, "User not found!"}

      iex> get_user!("E28A0786-6E6E-4B9F-9ED3-3088266E0089")
      {:error, "Invalid ID format!"}

  """
  @spec get_user!(integer() | String.t()) :: {:ok, %User{}} | {:error, String.t()}
  defdelegate get_user!(id), to: User.Get, as: :call

  @doc """
  Atualiza um usuário. O usuário só pode atualizar seu nome e seu password se necessário.

  ## Parameters

    - params: Map contendo os dados inicias do usuário. Examplo: %{id: 1, name: "Servian", password: "Cc5_555"}

  ## Examples

      iex> update_user(%{id: 1, name: "Servian"})
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

      iex> update_user(%{id: 1, password: "ScR55@55"})
      {
        :ok,
        %BankingApi.Accounts.User{
          __meta__: #Ecto.Schema.Metadata<:loaded, "users">,
          balance: 100000,
          cpf: "01122233304",
          email: "alexandreservian@gmail.com",
          id: 1,
          inserted_at: ~N[2020-11-30 00:25:30],
          name: "Servian",
          password: "ScR55@55",
          password_hash: "$2b$12$bUu037dzZ3XHZfyn5vzqEOr//sfZsmRI.Te5vGSSmsVOrSE2.Fvl2"",
          updated_at: ~N[2020-11-30 23:40:15]
        }
      }

      iex> update_user(%{id: 2, name: ""})
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

      iex> update_user(%{id: 15, name: "Servian"})
      {:error, "User not found!"}

      iex> update_user(%{id: "E28A0786-6E6E-4B9F-9ED3-3088266E0089", name: "Servian"})
      {:error, "Invalid ID format!"}

  """
  @spec update_user(%{
          :id => integer() | String.t(),
          optional(:name) => binary,
          optional(:password) => binary
        }) ::
          {:ok, %User{}} | {:error, Ecto.Changeset.t()} | {:error, String.t()}
  defdelegate update_user(params), to: User.Update, as: :call

  @doc """
  Deleta um usuário.

  ## Parameters

    - id: Integer

  ## Examples

      iex> delete_user(2)
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

      iex> delete_user(15)
      {:error, "User not found!"}

      iex> delete_user("E28A0786-6E6E-4B9F-9ED3-3088266E0089")
      {:error, "Invalid ID format!"}

  """
  @spec delete_user(integer() | String.t()) ::
          {:ok, %User{}} | {:error, String.t()}
  defdelegate delete_user(id), to: User.Delete, as: :call
end
