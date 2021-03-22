defmodule Exlivery.Orders.CreateOrUpdateTest do
  use ExUnit.Case
  alias Exlivery.Orders.Order
  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Orders.CreateOrUpdate
  import Exlivery.Factory

  describe "call/1" do
    setup do
      OrderAgent.start_link(%{})
      UserAgent.start_link(%{})
      cpf = "123123123"
      build(:user, cpf: cpf)
      |>UserAgent.save()

      item1 = %{
        category: :pizza,
        description: "pizza duh",
        quantity: 1,
        unit_price: "50.00"
      }

      item2 = %{
        category: :pizza,
        description: "pizzaaaaaaaa",
        quantity: 1,
        unit_price: "55.00"
      }

      {:ok, user_cpf: cpf, item1: item1, item2: item2 }
    end

    test "when all params are valid saves the order", %{user_cpf: cpf, item1: item1, item2: item2} do
      params = %{user_cpf: cpf, items: [item1, item2]}

      response = CreateOrUpdate.call(params)
      assert{:ok, _uuid} = response
    end

    test "when there is no user with given cpf returns an error", %{item1: item1, item2: item2} do
      params = %{user_cpf: 111111, items: [item1, item2]}

      response = CreateOrUpdate.call(params)
      expected_response = {:error, "User not found"}
      assert response == expected_response
    end

    test "when there are invalid items returns an error", %{user_cpf: cpf, item1: item1, item2: item2} do
      params = %{user_cpf: cpf, items: [%{item1 | quantity: 0}, item2]}

      response = CreateOrUpdate.call(params)
      expected_response = {:error, "Invalid parameters"}
      assert response == expected_response
    end

    test "when there are no items returns an error", %{user_cpf: cpf} do
      params = %{user_cpf: cpf, items: []}

      response = CreateOrUpdate.call(params)
      expected_response = {:error, "Invalid parameters"}
      assert response == expected_response
    end

  end

end
