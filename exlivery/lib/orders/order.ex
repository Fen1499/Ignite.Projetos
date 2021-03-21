defmodule Exlivery.Orders.Order do
  @keys [:user_cpf, :delivery_address, :items, :total_price]

  @enforce_keys @keys
  defstruct @keys

  def build do

  end
end
