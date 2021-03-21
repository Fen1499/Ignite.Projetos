defmodule Exlivery.Orders.ItemTest do
  use ExUnit.Case
  alias Exlivery.Orders.Item
  import Exlivery.Factory

  describe "build/4" do
    test "when all parameters are valid" do
      response = Item.build("alimento", :pizza, "49.90", 2)
      expected_response = {:ok, build(:item)}

      assert response == expected_response
    end

    test "when there is an invalid category returns an error" do
      response = Item.build("alimento", :nooo, "49.90", 2)
      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end

    test "when there is an invalid price returns an error" do
      response = Item.build("alimento", :pizza, "woosh", 2)
      expected_response = {:error, "Invalid price"}

      assert response == expected_response
    end

    test "when there is an invalid quantity returns an error" do
      response = Item.build("alimento", :nooo, "49.90", 0)
      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
