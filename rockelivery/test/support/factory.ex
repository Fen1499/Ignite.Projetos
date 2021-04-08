defmodule Rockelivery.Factory do
  use ExMachina.Ecto, repo: Rockelivery.Repo
  alias Rockelivery.Users.User

  def user_params_factory do
    %{
      "age" => 26,
      "address" => "Rua aaa",
      "cep" => "27950040",
      "cpf" => "00000000000",
      "email" => "f@f.com",
      "password" => "123456",
      "name" => "fen"
    }
  end

  def user_factory do
    %User{
      id: "a9d8fb0e-7754-41f2-9ff4-1b0c22ffb5dd",
      age: 26,
      address: "Rua aaa",
      cep: "27950040",
      cpf: "00000000000",
      email: "f@f.com",
      password: "123456",
      name: "fen"
    }
  end
end
