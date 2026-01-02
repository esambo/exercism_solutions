defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  Underscore (_) are ignored and split words apart.
  Digits, dashes (-) and German umlaute are included as part of a word.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    remaining_words =
      sentence
      |> String.downcase
      |> String.replace(~r/_/, " ")
      |> String.replace(~r/[^a-z0-9\-äöüß ]/, "")
      |> String.split(~r/\s+/)
    occurances(remaining_words, %{})
  end

  @spec occurances([String.t()], map) :: map
  defp occurances([], result) do
    result
  end

  defp occurances([word | remaining_words], result) do
    updated_result = Map.update(result, word, 1, &(&1+1))
    occurances(remaining_words, updated_result)
  end
end
