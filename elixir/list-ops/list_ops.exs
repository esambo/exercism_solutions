defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(l) do
    do_count(l, 0)
  end

  defp do_count([], i) do
    i
  end

  defp do_count([_hd | rest], i) do
    do_count(rest, i + 1)
  end

  @spec reverse(list) :: list
  def reverse(l) do
    do_reverse(l, [])
  end

  defp do_reverse([], reversed) do
    reversed
  end

  defp do_reverse([current | rest], reversed) do
    do_reverse(rest, [current | reversed])
  end

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    l
    |> do_map(f, [])
    |> reverse()
  end

  defp do_map([], _f, result) do
    result
  end

  defp do_map([hd | tail], f, result) do
    do_map(tail, f, [f.(hd) | result])
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([], _f) do
    []
  end

  def filter([hd | tail], f) do
    if f.(hd) do
      [hd | filter(tail, f)]
    else
      filter(tail, f)
    end
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([], acc, _f) do
    acc
  end

  def reduce([hd | tail], acc, f) do
    reduce(tail, f.(hd, acc), f)
  end

  @spec append(list, list) :: list
  def append(_a, _b) do
  end

  @spec concat([[any]]) :: [any]
  def concat(_ll) do
  end
end
