defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}
  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, key) do
    [left, right] = [0, tuple_size(numbers) - 1]
    search(numbers, key, left, right)
  end

  defp search(numbers, key, left, right) do
    index = left + div(right - left, 2)
    search(numbers, key, left, right, index)
  end

  defp search(_numbers, _key, left, right, _index) when left > right do
    :not_found
  end

  defp search(numbers, key, _left, _right, index) when elem(numbers, index) == key do
    {:ok, index}
  end

  defp search(numbers, key, _left, right, index) when elem(numbers, index) < key do
    left = index + 1
    search(numbers, key, left, right)
  end

  defp search(numbers, key, left, _right, index) do
    right = index - 1
    search(numbers, key, left, right)
  end
end
