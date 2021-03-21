defmodule Exlivery.Factory do
  use ExMachina
  alias Exlivery.Users.User
  alias Exlivery.Orders.{Item, Order}

  def user_factory do
    %User{
      address: "Rua das ruas",
      age: 26,
      cpf: "123456",
      email: "F@F.com",
      name: "Fen"
    }
  end

  def item_factory do
    %Item{
      category: :pizza,
      description: "alimento",
      quantity: 2,
      unit_price: Decimal.new("49.90")
    }
  end

  def order_factory do
    %Order{
      delivery_address: "Rua das ruas",
      items: [
        %Item{
          category: :pizza,
          description: "alimento",
          quantity: 2,
          unit_price: Decimal.new("49.90")
        },
        %Item{
          category: :japonesa,
          description: "Sushiiii",
          quantity: 1,
          unit_price: Decimal.new("49.90")
        }
      ],
      total_price: Decimal.new("149.70"),
      user_cpf: "123456"
    }
  end

end
