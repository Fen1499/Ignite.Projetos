defmodule ReportGeneratorTest do
  use ExUnit.Case

  describe "build\1" do
    test "builds the report" do
      file_name = "report_test.csv"

      response = ReportGenerator.build(file_name)
      expected_response = %{"foods" => %{"a├ºa├¡" => 1, "churrasco" => 2, "esfirra" => 3, "hamb├║rguer" => 2, "pastel" => 0, "pizza" => 2, "prato_feito" => 0, "sushi" => 0}, "users" => %{"1" => 48, "10" => 36, "11" => 0, "12" => 0, "13" => 0, "14" => 0, "15" => 0, "16" => 0, "17" => 0, "18" => 0, "19" => 0, "2" => 45, "20" => 0, "21" => 0, "22" => 0, "23" => 0, "24" => 0, "25" => 0, "26" => 0, "27" => 0, "28" => 0, "29" => 0, "3" => 31, "30" => 0, "4" => 42, "5" => 49, "6" => 18, "7" => 27, "8" => 25, "9" => 24}}

      assert response == expected_response
    end
  end

  describe "build_from_many\1" do
    test "when a file list is provided builds the report" do
      file_name = "report_test.csv"

      response = ReportGenerator.build_from_many([file_name, file_name])
      expected_response =  {:ok, %{"foods" => %{"a├ºa├¡" => 1, "churrasco" => 2, "esfirra" => 3, "hamb├║rguer" => 2, "pastel" => 0, "pizza" => 2, "prato_feito" => 0, "sushi" => 0}, "users" => %{"1" => 48, "10" => 36, "11" => 0, "12" => 0, "13" => 0, "14" => 0, "15" => 0, "16" => 0, "17" => 0, "18" => 0, "19" => 0, "2" => 45, "20" => 0, "21" => 0, "22" => 0, "23" => 0, "24" => 0, "25" => 0, "26" => 0, "27" => 0, "28"
        => 0, "29" => 0, "3" => 31, "30" => 0, "4" => 42, "5" => 49, "6" => 18, "7" => 27, "8" => 25, "9" => 24}}}

      assert response == expected_response
    end

    test "when a file build is provided returns an error" do
      response = ReportGenerator.build_from_many("eh")
      expected_response = {:error, "please provide a list of strings!"}

      assert response == expected_response
    end
  end

  describe "fetch_higher_cost\2" do

    test "when the option is 'users', returns the user who spent the most" do
      file_name = "report_test.csv"

      response = file_name
        |> ReportGenerator.build()
        |> ReportGenerator.fetch_higher_cost("users")
      expected_response = {:ok, {"5", 49}}

      assert response == expected_response

    end

    test "when the option is 'foods', returns the most consumed food" do
      file_name = "report_test.csv"

      response = file_name
        |> ReportGenerator.build()
        |> ReportGenerator.fetch_higher_cost("foods")
      expected_response = {:ok, {"esfirra", 3}}

      assert response == expected_response

    end

    test "when the option is invalid returns error" do
      file_name = "report_test.csv"

      response = file_name
        |> ReportGenerator.build()
        |> ReportGenerator.fetch_higher_cost("erro")
      expected_response = {:error, "invalid option!"}

      assert response == expected_response

    end
  end
end
