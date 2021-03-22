defmodule Exlivery.Users.CreateOrUpdateTest do
  use ExUnit.Case
  alias Exlivery.Users.User
  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.CreateOrUpdate
  import Exlivery.Factory

  describe "call/1" do
    setup do
      UserAgent.start_link(%{})
      :ok
    end

    test "when all params are valid, saves the user" do
      params = %{name: "fen", address: "rua", email: "email@email.com", cpf: "123123123", age: 26}

      response = CreateOrUpdate.call(params)
      expected_response = {:ok, "User created or updated succesfully"}
      assert response == expected_response
    end

    test "when there are invalid params, return an error" do
      params = %{name: "fen", address: "rua", email: "email@email.com", cpf: "123123123", age: 9}

      response = CreateOrUpdate.call(params)
      expected_response = {:error, "Invalid parameters"}
      assert response == expected_response
    end
  end
end
