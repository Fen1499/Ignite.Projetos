defmodule Rockelivery.Users.UserTest do
  use Rockelivery.DataCase, async: true
  alias Rockelivery.Users.User
  alias Ecto.Changeset
  import Rockelivery.Factory

  describe "changeset/2" do
    test "when all params are valid, returns a valid changeset" do
      params = build(:user_params)

      response = User.changeset(params)
      assert %Changeset{changes: %{name: "fen"}, valid?: true } = response
    end

    test "when updating a changeset, returns a valid changeset with the given changes" do
      params = build(:user_params)

      changeset = User.changeset(params)
      response = User.changeset(changeset, %{"name" => "FELIPE"})
      assert %Changeset{changes: %{name: "FELIPE"}, valid?: true } = response
    end

    test "when there are errors returns an invalid changeset" do
      params = %{
        age: 26,
        address: "Rua aaa",
        cep: "27950040",
        cpf: "000000000",
        email: "f.com",
        password: "1236",
        name: "fen"
      }

      response = User.changeset(params)
      expected_response = %{
        cpf: ["should be 11 character(s)"],
        email: ["has invalid format"],
        password: ["should be at least 6 character(s)"]
      }

      assert expected_response == errors_on(response)
    end
  end
end
