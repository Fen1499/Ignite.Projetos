defmodule Rockelivery.Orders.ValidateMultiplyItems do
  def call(items, items_ids, items_params) do
    items_map = Map.new(items, fn item -> {item.id, item} end)

    items_ids
    |> Enum.map(fn id -> {id, Map.get(items_map, id)} end)
    |> Enum.any?(fn {_id, value} -> is_nil(value) end)
    |> multiply_items(items_map, items_params)
    #outra maneira seria verificar se algum valor fica fora da interseção
  end

  defp multiply_items(true, _items, _items_params), do: {:error, "Invalid ids!"}
  defp multiply_items(false, items, items_params) do
    items =
    Enum.reduce(items_params, [], fn %{"id" => id, "quantity" => quantity}, acc ->
      item = Map.get(items, id)
      acc ++ List.duplicate(item, quantity)
    end)

    {:ok, items}
  end
end
