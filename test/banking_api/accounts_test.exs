defmodule BankingApi.AccountsTest do
  use BankingApi.DataCase

  alias BankingApi.Accounts

  describe "users" do
    alias BankingApi.Accounts.User

    @valid_attrs %{account_number: 42, balance: 42, cpf: "some cpf", email: "some email", name: "some name", password_hash: "some password_hash"}
    @update_attrs %{account_number: 43, balance: 43, cpf: "some updated cpf", email: "some updated email", name: "some updated name", password_hash: "some updated password_hash"}
    @invalid_attrs %{account_number: nil, balance: nil, cpf: nil, email: nil, name: nil, password_hash: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.account_number == 42
      assert user.balance == 42
      assert user.cpf == "some cpf"
      assert user.email == "some email"
      assert user.name == "some name"
      assert user.password_hash == "some password_hash"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.account_number == 43
      assert user.balance == 43
      assert user.cpf == "some updated cpf"
      assert user.email == "some updated email"
      assert user.name == "some updated name"
      assert user.password_hash == "some updated password_hash"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end