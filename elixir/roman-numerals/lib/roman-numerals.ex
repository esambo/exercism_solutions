defmodule Roman do
  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t()
  def numerals(number) do
    to_roman(number, "")
  end

  @spec to_roman(pos_integer, String.t()) :: String.t()
  defp to_roman(0, result) do
    result
  end

  defp to_roman(number, result) do
    found =
      case number do
        n when div(n, 1_000) in 1..3 -> %{applied: 1_000 * div(n, 1_000), result: String.duplicate("M", div(n, 1_000))}
        n when div(n, 900) == 1 and rem(n, 900) in 0..99 -> %{applied: 900, result: "CM"}
        n when div(n, 500) in 1..3 -> %{applied: 500, result: "D"}
        n when div(n, 400) == 1 and rem(n, 400) in 0..99 -> %{applied: 400, result: "CD"}
        n when div(n, 100) in 1..3 -> %{applied: 100 * div(n, 100), result: String.duplicate("C", div(n, 100))}
        n when div(n, 90) == 1 and rem(n, 90) in 0..9 -> %{applied: 90, result: "XC"}
        n when div(n, 50) in 1..3 -> %{applied: 50, result: "L"}
        n when div(n, 40) == 1 and rem(n, 40) in 0..9 -> %{applied: 40, result: "XL"}
        n when div(n, 10) in 1..3 -> %{applied: 10 * div(n, 10), result: String.duplicate("X", div(n, 10))}
        9 -> %{applied: 9, result: "IX"}
        n when div(n, 5) in 1..3 -> %{applied: 5, result: "V"}
        5 -> %{applied: 5, result: "V"}
        4 -> %{applied: 4, result: "IV"}
        n when n in 1..3 -> %{applied: n, result: String.duplicate("I", n)}
      end
    to_roman(number - found.applied, "#{result}#{found.result}")
  end
end
