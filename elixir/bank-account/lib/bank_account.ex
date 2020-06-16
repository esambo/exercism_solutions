defmodule BankAccount do
  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  # API

  use GenServer

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank() do
    {:ok, account} = GenServer.start_link(__MODULE__, 0)
    account
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(account) do
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account) do
    GenServer.call(account, :balance)
  end

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount) do
  end

  # Callbacks

  @impl true
  def init(account) do
    {:ok, account}
  end

  @impl true
  def handle_call(:balance, _from, balance) do
    {:reply, balance, balance}
  end
end
