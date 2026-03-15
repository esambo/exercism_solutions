defmodule Zipper do
  @moduledoc """
  A zipper for a binary tree.

  `path:` Zipper.t() or nil of the node we previously came from
  `parent`: BinTree or nil of the node we just decomposed
  `from:` :left or :right or nil of the direction we just extracted from the parent
  `node`: BinTree or nil of the node we extracted at direction from the parent and currently have in focus. If it's nil, the entire Zipper is nil!
  """

  @type t :: %Zipper{
          path: Zipper.t() | nil,
          parent: BinTree.t() | nil,
          from: :left | :right | nil,
          node: BinTree.t() | nil
        }

  defstruct [:path, :parent, :from, :node]

  @doc """
  Get a zipper focused on the root node.
  """
  @spec from_tree(BinTree.t()) :: Zipper.t()
  def from_tree(bin_tree) do
    %Zipper{
      node: bin_tree
    }
  end

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Zipper.t()) :: BinTree.t()
  def to_tree(%Zipper{path: nil, from: nil} = zipper) do
    zipper.node
  end

  # %Zipper{
  #   path: %Zipper{
  #     path: %Zipper{
  #       path: nil,
  #       parent: nil,
  #       from: nil,
  #       node: (1:(2::(3::)):(4::))
  #     },
  #     parent: (1:(2::(3::)):(4::)),
  #     from: :left,
  #     node: (2::(3::))
  #   },
  #   parent: (2::(3::)),
  #   from: :right,
  #   node: (3::)
  # }
  # t1:    .____1____.
  #        2__.      4
  #           3
  def to_tree(zipper) do
    zipper
    |> up()
    |> to_tree()
  end

  @doc """
  Get the value of the focus node.
  """
  @spec value(Zipper.t()) :: any
  def value(zipper) do
    zipper.node.value
  end

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Zipper.t()) :: Zipper.t() | nil
  def left(%Zipper{node: %BinTree{left: nil}}) do
    nil
  end

  def left(zipper) do
    %Zipper{
      path: zipper,
      parent: zipper.node,
      from: :left,
      node: zipper.node.left
    }
  end

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Zipper.t()) :: Zipper.t() | nil
  def right(%Zipper{node: %BinTree{right: nil}}) do
    nil
  end

  def right(zipper) do
    %Zipper{
      path: zipper,
      parent: zipper.node,
      from: :right,
      node: zipper.node.right
    }
  end

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Zipper.t()) :: Zipper.t() | nil
  def up(%Zipper{path: nil}) do
    nil
  end

  def up(%Zipper{path: %Zipper{}} = zipper) do
    %Zipper{
      zipper.path
      | node:
          struct!(
            zipper.parent,
            [{zipper.from, zipper.node}]
          )
    }
  end

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Zipper.t(), any) :: Zipper.t()
  def set_value(%Zipper{node: %BinTree{}} = zipper, value) do
    %Zipper{
      zipper
      | node: %BinTree{
          zipper.node
          | value: value
        }
    }
  end

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_left(%Zipper{node: %BinTree{}} = zipper, left) do
    %Zipper{
      zipper
      | node: %BinTree{
          zipper.node
          | left: left
        }
    }
  end

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_right(%Zipper{node: %BinTree{}} = zipper, right) do
    %Zipper{
      zipper
      | node: %BinTree{
          zipper.node
          | right: right
        }
    }
  end
end
