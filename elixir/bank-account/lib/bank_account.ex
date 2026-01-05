defmodule BankAccount do
  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  # Client

  use GenServer

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @doc """
  Open the bank account, making it available for further operations.
  """
  @spec open() :: account
  def open() do
    {:ok, account} = GenServer.start_link(__MODULE__, 0)
    account
  end

  @doc """
  Close the bank account, making it unavailable for further operations.
  """
  @spec close(account) :: any
  def close(account) do
    GenServer.stop(account)
  end

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer | {:error, :account_closed}
  def balance(account) do
    if Process.alive?(account) do
      GenServer.call(account, :balance)
    else
      {:error, :account_closed}
    end
  end

  @doc """
  Add the given amount to the account's balance.
  """
  @spec deposit(account, integer) :: :ok | {:error, :account_closed | :amount_must_be_positive}
  def deposit(account, amount) when amount > 0 do
    if Process.alive?(account) do
      :ok = GenServer.call(account, {:update, amount})
    else
      {:error, :account_closed}
    end
  end

  def deposit(_account, _amount) do
    {:error, :amount_must_be_positive}
  end

  @doc """
  Subtract the given amount from the account's balance.
  """
  @spec withdraw(account, integer) ::
          :ok | {:error, :account_closed | :amount_must_be_positive | :not_enough_balance}
  def withdraw(account, amount) when amount > 0 do
    if Process.alive?(account) do
      GenServer.call(account, {:update, -amount})
    else
      {:error, :account_closed}
    end
  end

  def withdraw(_account, _amount) do
    {:error, :amount_must_be_positive}
  end

  # Server (callbacks)

  @impl true
  def init(account) do
    {:ok, account}
  end

  @impl true
  def handle_call(:balance, _from, balance) do
    {:reply, balance, balance}
  end

  @impl true
  def handle_call({:update, amount}, _from, balance) when balance + amount >= 0 do
    new_balance = balance + amount
    {:reply, :ok, new_balance}
  end

  def handle_call({:update, _amount}, _from, balance) do
    {:reply, {:error, :not_enough_balance}, balance}
  end
end
