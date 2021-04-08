defmodule Rockelivery.Users.CreateTest do
  use Rockelivery.DataCase, async: true

  alias Rockelivery.Error
  alias Rockelivery.Users.{User, Create}

  import Rockelivery.Factory

  describe "call/1" do
    test "when all params are valid, returns an user" do
      response =
       build(:user_params)
      |>Create.call()

      assert {:ok, %User{id: _id, name: "fen"}} = response
    end

    test "when there are invalid params, returns an error" do
      response = build(:user_params, %{"email" => "f.com", "cpf" => "0"})
      |>Create.call()

      assert {:error, %Error{status: :bad_request, result: changeset}} = response

      exptected_response = %{cpf: ["should be 11 character(s)"], email: ["has invalid format"]}

      assert exptected_response == errors_on(changeset)
    end
  end
end
