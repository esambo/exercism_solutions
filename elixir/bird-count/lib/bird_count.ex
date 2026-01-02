defmodule BirdCount do
  def today([]) do
    nil
  end

  def today([today | _rest]) do
    today
  end

  def increment_day_count([]) do
    [1]
  end

  def increment_day_count([today | rest]) do
    [today + 1 | rest]
  end

  def has_day_without_birds?(list, has_birds \\ false)

  def has_day_without_birds?([], false) do
    false
  end

  def has_day_without_birds?([0 | _rest], _false) do
    true
  end

  def has_day_without_birds?([_today | rest], _false) do
    has_day_without_birds?(rest, false)
  end

  def total(list, total \\ 0)

  def total([], total) do
    total
  end

  def total([today | rest], total) do
    total(rest, total + today)
  end

  def busy_days(list, days \\ 0)

  def busy_days([], days) do
    days
  end

  def busy_days([today | rest], days) when today < 5 do
    busy_days(rest, days)
  end

  def busy_days([_today | rest], days) do
    busy_days(rest, days + 1)
  end
end
