defmodule RockeliveryWeb.UsersViewTest do
  use RockeliveryWeb.ConnCase, async: true
  alias RockeliveryWeb.UsersView

  import Phoenix.View
  import Rockelivery.Factory

  test "render create.json" do
    user = build(:user)

    response = render(UsersView, "create.json", user: user)
    assert %{message: "User created", user: %Rockelivery.Users.User{address: "Rua aaa", age: 26, cep: "27950040", cpf: "00000000000", email: "f@f.com", id: _, inserted_at: nil, name: "fen", password: "123456", password_hash: nil,
    updated_at: nil}} = response

  end
end
