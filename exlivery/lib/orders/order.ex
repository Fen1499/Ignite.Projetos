defmodule Exlivery.Orders.Order do
  alias Exlivery.Users.User
  alias Exlivery.Orders.Item
  @keys [:user_cpf, :delivery_address, :items, :total_price]

  @enforce_keys @keys
  defstruct @keys

  def build(%User{cpf: cpf, address: adrress}, [%Item{} | _items] = items) do
    {:ok,
    %__MODULE__{
      user_cpf: cpf,
      delivery_address: adrress,
      items: items,
      total_price: calculate_total_price(items)
      }
    }
  end

  def build(_Users, _Item), do: {:error, "Invalid parameters"}

  defp calculate_total_price(items) do
    Enum.reduce(items, Decimal.new("0.00"), &sum_prices(&1, &2))
  end

  defp sum_prices(%Item{unit_price: price, quantity: quantity}, acc) do
    price
    |> Decimal.mult(quantity)
    |> Decimal.add(acc)
  end
end
