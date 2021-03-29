defmodule Exlivery.Orders.ReportTest do
  use ExUnit.Case
  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.Report
  import Exlivery.Factory

  describe "create/1" do
    test "create_the_report_file" do
      OrderAgent.start_link(%{})

      :order
      |>build()
      |>OrderAgent.save

      :order
      |>build()
      |>OrderAgent.save

      Report.create("report_test.csv")
      response = File.read("report_test.csv")
      expected_response = {:ok, "123456,pizza,2,49.90japonesa,1,49.90,149.70\n123456,pizza,2,49.90japonesa,1,49.90,149.70\n"}

      assert response == expected_response


    end
  end
end
