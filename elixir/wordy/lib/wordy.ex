defmodule Wordy do
  @doc """
  Calculate the math problem in the sentence.
  """
  @spec answer(String.t()) :: integer
  def answer(question) do
    question
    |> parse_sub_question()
    |> calc_left_to_right()
    |> result()
  end

  defp parse_sub_question(question) do
    question
    |> String.split(["What is ", "?"])
    |> Enum.at(1)
  end

  defp calc_left_to_right(sub_question) do
    ~r{(^(?<left>-?\d+)( (?<operation>plus|minus|divided by|multiplied by) (?<right>-?\d+)(?<rest>.*))*$)|(^(?<error>.*)$)}
    |> Regex.named_captures(sub_question)
    |> Map.new(fn {key, val} -> {String.to_existing_atom(key), val} end)
    |> calc()
  end

  defp calc(%{left: left, operation: "", right: "", rest: "", error: ""}) do
    left
  end

  defp calc(%{left: left, operation: "plus", right: right, rest: rest}) do
    "#{String.to_integer(left) + String.to_integer(right)}#{rest}"
    |> calc_left_to_right()
  end

  defp calc(%{left: left, operation: "minus", right: right, rest: rest}) do
    "#{String.to_integer(left) - String.to_integer(right)}#{rest}"
    |> calc_left_to_right()
  end

  defp calc(%{left: left, operation: "multiplied by", right: right, rest: rest}) do
    "#{String.to_integer(left) * String.to_integer(right)}#{rest}"
    |> calc_left_to_right()
  end

  defp calc(%{left: left, operation: "divided by", right: right, rest: rest}) do
    "#{div(String.to_integer(left), String.to_integer(right))}#{rest}"
    |> calc_left_to_right()
  end

  defp calc(%{left: "", error: error}) do
    raise ArgumentError, "Unexpected pattern: \"#{error}\""
  end

  defp result(string) do
    String.to_integer(string)
  end
end
