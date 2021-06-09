defmodule RockeliveryWeb.UsersControllerTest do
  use RockeliveryWeb.ConnCase, async: true

  import Mox
  import Rockelivery.Factory

  alias Rockelivery.ViaCep.ClientMock

  describe "create/2" do
    test "when all params are valid, creates the user", %{conn: conn} do
      params = build(:user_params)

      expect(ClientMock, :get_cep_info, fn _cep ->
        {:ok, %{}}
      end)

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

        assert %{
          "message" => "User created",
          "user" => %{
            "address" => "Rua aaa",
            "age" => 26,
            "cep" => "27950040",
            "cpf" => "00000000000",
            "email" => "f@f.com",
            "id" => _uuid,
            "name" => "fen"
          }
        } = response
    end

    test "when there are errors, returns an error", %{conn: conn} do
      params = build(:user_params, %{"age" => 5})

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:bad_request)

        assert %{"message" => %{"age" => ["must be greater than or equal to 18"]}} == response
    end
  end

  describe "delete/2" do
    test "when there is an user with the given id, deletes the user", %{conn: conn} do
      id = "a9d8fb0e-7754-41f2-9ff4-1b0c22ffb5dd"
      insert(:user)

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, id))
        |> response(:no_content)

      assert response == ""
    end
  end

end
