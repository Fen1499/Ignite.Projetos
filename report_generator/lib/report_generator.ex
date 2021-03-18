defmodule ReportGenerator do
  alias ReportGenerator.Parser

  @avalible_foods [
    "açaí",
    "churrasco",
    "hambúrguer",
    "esfirra",
    "pastel",
    "pizza",
    "prato_feito",
    "sushi"
  ]

  @options [
    "foods",
    "users"
  ]

  def build(filename) do
    filename
    |> Parser.parse_file()
    |> Enum.reduce(report_acc(), &sum_values/2)
  end

  def fetch_higher_cost(report, option) when option in @options do
    {:ok, Enum.max_by(report[option], fn {_k, v} -> v end)}
  end
  def fetch_higher_cost(_report, _option), do: {:error, "invalid option!"}

  defp sum_values([id, food_name, price], %{"foods" => foods, "users" => users} = report) do
    users = Map.put(users, id, users[id] + price)
    foods = Map.put(foods, food_name, foods[food_name] + 1)
    %{report | "users" => users, "foods" => foods}
  end

  defp report_acc do
    foods = Enum.into(@avalible_foods, %{}, &{&1, 0})
    users = Enum.into(1..30, %{}, &{Integer.to_string(&1), 0})

    %{
      "users" => users,
      "foods" => foods
    }
  end
end
