defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `count`.

  @spec count(list) :: non_neg_integer
  @spec count(list, non_neg_integer()) :: non_neg_integer()
  def count(l, i \\ 0)

  def count([], i) do
    i
  end

  def count([_hd | rest], i) do
    count(rest, i + 1)
  end

  @spec reverse(list) :: list
  @spec reverse(list, list) :: list
  def reverse(l, reversed \\ [])

  def reverse([], reversed) do
    reversed
  end

  def reverse([current | rest], reversed) do
    reverse(rest, [current | reversed])
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
  @spec foldl(list, acc, (any, acc -> acc)) :: acc
  def foldl([], acc, _f) do
    acc
  end

  def foldl([hd | tail], acc, f) do
    foldl(tail, f.(hd, acc), f)
  end

  @spec foldr(list, acc, (any, acc -> acc)) :: acc
  def foldr(l, acc, f) do
    l |> reverse() |> foldl(acc, f)
  end

  @spec append(list, list) :: list
  def append([], b) do
    b
  end

  def append([hd | tail], b) do
    [hd | append(tail, b)]
  end

  @spec concat([[any]]) :: [any]
  def concat([]) do
    []
  end

  def concat([hd_list | tail_list]) do
    append(hd_list, concat(tail_list))
  end
end
