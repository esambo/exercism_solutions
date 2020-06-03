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
  def map(_l, _f) do
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(_l, _f) do
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce(_l, _acc, _f) do
  end

  @spec append(list, list) :: list
  def append(_a, _b) do
  end

  @spec concat([[any]]) :: [any]
  def concat(_ll) do
  end
end
