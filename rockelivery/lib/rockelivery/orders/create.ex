defmodule Rockelivery.Orders.Create do
  alias Rockelivery.{Error, Repo, Orders.Order, Orders.ValidateMultiplyItems, Items.Item}
  import Ecto.Query

  def call(params) do
    params
    |> fetch_items()
    |> handle_items(params)
  end

  defp fetch_items(%{"items" => items_params}) do
    items_ids = Enum.map(items_params, fn item -> item["id"] end)
    query = from item in Item, where: item.id in ^items_ids

    query
    |> Repo.all()
    |> ValidateMultiplyItems.call(items_ids, items_params)
  end

  defp handle_items({:error, result}, _params), do: {:error, Error.build(:bad_request, result)}
  defp handle_items({:ok, items}, params) do
    params
    |> Order.changeset(items)
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Order{}} = result), do: result
  defp handle_insert({:error, result}), do: {:error, Error.build(:bad_request, result)}
end
