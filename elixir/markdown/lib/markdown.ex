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
    |> enclose_with_unordered_list_tag()
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
      :list -> enclose_with_list_item_tag(line)
      :paragraph -> enclose_with_paragraph_tag(line)
    end
  end

  defp parse_block_type("#" <> _), do: :header
  defp parse_block_type("* " <> _), do: :list
  defp parse_block_type(_), do: :paragraph

  defp parse_header_md_level("# " <> t), do: {"1", t}
  defp parse_header_md_level("## " <> t), do: {"2", t}
  defp parse_header_md_level("### " <> t), do: {"3", t}
  defp parse_header_md_level("#### " <> t), do: {"4", t}
  defp parse_header_md_level("##### " <> t), do: {"5", t}
  defp parse_header_md_level("###### " <> t), do: {"6", t}

  defp parse_list_md("* " <> t), do: t

  defp enclose_with_list_item_tag(line) do
    line
    |> parse_list_md()
    |> parse_inline_md()
    |> tag_as("li")
  end

  defp enclose_with_header_tag(line) do
    {level, text} = parse_header_md_level(line)
    tag_as(text, "h#{level}")
  end

  defp enclose_with_paragraph_tag(line) do
    line
    |> parse_inline_md()
    |> tag_as("p")
  end

  defp parse_inline_md(line) do
    line
    |> replace_strong_md()
    |> replace_em_md()
  end

  defp replace_strong_md(line) do
    Regex.replace(~r/(?<=^| )(__.+__)(?=$| )/, line, fn _, x ->
      x
      |> chop_ends_off_by(2)
      |> tag_as("strong")
    end)
  end

  defp replace_em_md(line) do
    Regex.replace(~r/(?<=^| )(_.+_)(?=$| )/, line, fn _, x ->
      x
      |> chop_ends_off_by(1)
      |> tag_as("em")
    end)
  end

  defp chop_ends_off_by(text, chars) do
    String.slice(text, chars..-(chars + 1))
  end

  defp tag_as(text, tag) do
    "<#{tag}>#{text}</#{tag}>"
  end

  defp enclose_with_unordered_list_tag(html) do
    html
    |> String.replace("<li>", "<ul><li>", global: false)
    |> String.replace_suffix("</li>", "</li></ul>")
  end
end
