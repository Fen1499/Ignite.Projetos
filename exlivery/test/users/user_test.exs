defmodule Exlivery.Users.UsersTest do
  use ExUnit.Case
  alias Exlivery.Users.User
  import Exlivery.Factory

  describe "build/5" do
    test "when all params are valid returns the user" do
      response = User.build("Fen", "F@F.com", "123456", 26, "Rua das ruas")
      expected_response = {:ok, build(:user)}

      assert response == expected_response
    end

    test "when there are invalid parameters returns an error" do
      response = User.build("Fen", "F@F.com", 999, 9, "Rua das ruas")
      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end

end
