defmodule Bob do
  def hey(input) do
    cond do
      without_actually_saying_anything?(input) -> "Fine. Be that way!"
      yell_question?(input) -> "Calm down, I know what I'm doing!"
      yell?(input) -> "Whoa, chill out!"
      question?(input) -> "Sure."
      true -> "Whatever."
    end
  end

  defp question?(input) do
    String.ends_with?(input, "?")
  end

  defp yell?(input) do
    String.upcase(input) == input && !numbers?(input)
  end

  defp yell_question?(input) do
    yell?(input) && question?(input)
  end

  defp without_actually_saying_anything?(input) do
    String.trim(input) == ""
  end

  defp numbers?(input) do
    String.match?(input, ~r/^[\d,? ]+$/)
  end
end
