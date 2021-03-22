defmodule Exlivery.Users.AgentTest do
  use ExUnit.Case
  alias Exlivery.Users.Agent, as: UserAgent
  import Exlivery.Factory

  describe "save/1" do
    test "saves the user" do
      user = build(:user)
      UserAgent.start_link(%{})

      assert UserAgent.save(user) == :ok
    end
  end

  describe "get/1" do
    setup  do
      UserAgent.start_link(%{})
      cpf = "123123123"
      {:ok, cpf: cpf}
    end

    test "when the user is found, returns the user" do
      UserAgent.start_link(%{})

      :user
      |>build(cpf: "123123123")
      |>UserAgent.save()

      response = UserAgent.get("123123123")
      expected_response = {:ok, %Exlivery.Users.User{address: "Rua das ruas", age: 26, cpf: "123123123", email: "F@F.com", name: "Fen"}}
      assert response == expected_response

    end

    test "when the user is not found, returns an error" do
      response = UserAgent.get("1111")
      expected_response = {:error, "User not found"}
      assert response == expected_response
    end
  end

end
