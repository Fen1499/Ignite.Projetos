defmodule ReportGenerator do

  alias ReportGenerator.Parser
  def build(filename) do
    filename
    |> Parser.parse_file()
    |> Enum.reduce(report_acc(), &sum_values/2)
  end

  def fetch_higher_cost(report), do: Enum.max_by(report, fn {_k, v} -> v end)

  defp sum_values([id, _food_name, price], report), do: Map.put(report, id, report[id] + price)
  defp report_acc, do: Enum.into(1..30, %{}, &{Integer.to_string(&1), 0})
end
