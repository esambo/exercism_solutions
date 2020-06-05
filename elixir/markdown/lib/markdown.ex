defmodule Markdown do
  @moduledoc """
  [Markdown syntax](https://guides.github.com/features/mastering-markdown/).
  """

  @doc ~S"""
  Parses a given string with Markdown syntax and returns the associated HTML for that string.

  ## Examples

      iex> Markdown.parse("This is a paragraph")
      "<p>This is a paragraph</p>"

      iex> Markdown.parse("# Header!\n* __Bold Item__\n* _Italic Item_")
      "<h1>Header!</h1><ul><li><strong>Bold Item</strong></li><li><em>Italic Item</em></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(markdown) do
    markdown
    |> split_lines()
    |> process_all_lines()
    |> combine_lines()
    |> enclose_with_list_tag()
  end

  defp split_lines(markdown) do
    String.split(markdown, "\n")
  end

  defp combine_lines(lines) do
    Enum.join(lines)
  end

  defp process_all_lines(lines) do
    Enum.map(lines, &process/1)
  end

  defp process(line) do
    case parse_block_type(line) do
      :header -> enclose_with_header_tag(line)
      :list -> parse_list_md_level(line)
      _ -> enclose_with_paragraph_tag(line)
    end
  end

  defp parse_block_type("#" <> _), do: :header
  defp parse_block_type("*" <> _), do: :list
  defp parse_block_type(_), do: :paragraph

  defp parse_header_md_level("# " <> t), do: {"1", t}
  defp parse_header_md_level("## " <> t), do: {"2", t}
  defp parse_header_md_level("### " <> t), do: {"3", t}
  defp parse_header_md_level("#### " <> t), do: {"4", t}
  defp parse_header_md_level("##### " <> t), do: {"5", t}
  defp parse_header_md_level("###### " <> t), do: {"6", t}

  defp parse_list_md_level(line) do
    words = String.split(String.trim_leading(line, "* "))
    "<li>#{join_words_with_tags(words)}</li>"
  end

  defp enclose_with_header_tag(line) do
    {level, text} = parse_header_md_level(line)
    "<h#{level}>#{text}</h#{level}>"
  end

  defp enclose_with_paragraph_tag(line) do
    words = String.split(line)
    "<p>#{join_words_with_tags(words)}</p>"
  end

  defp join_words_with_tags(words) do
    words
    |> Enum.map(&replace_md_with_tag/1)
    |> Enum.join(" ")
  end

  defp replace_md_with_tag(word) do
    word
    |> replace_prefix_md()
    |> replace_suffix_md()
  end

  defp replace_prefix_md(word) do
    cond do
      word =~ ~r/^#{"__"}{1}/ -> String.replace(word, ~r/^#{"__"}{1}/, "<strong>", global: false)
      word =~ ~r/^[#{"_"}{1}][^#{"_"}+]/ -> String.replace(word, ~r/_/, "<em>", global: false)
      true -> word
    end
  end

  defp replace_suffix_md(word) do
    cond do
      word =~ ~r/#{"__"}{1}$/ -> String.replace(word, ~r/#{"__"}{1}$/, "</strong>")
      word =~ ~r/[^#{"_"}{1}]/ -> String.replace(word, ~r/_/, "</em>")
      true -> word
    end
  end

  defp enclose_with_list_tag(line) do
    line
    |> String.replace("<li>", "<ul><li>", global: false)
    |> String.replace_suffix("</li>", "</li></ul>")
  end
end
