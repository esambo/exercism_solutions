defmodule Lasagna do
  def expected_minutes_in_oven do
    40
  end

  def remaining_minutes_in_oven(actual) do
    expected_minutes_in_oven() - actual
  end

  def preparation_time_in_minutes(layers) do
    layers * 2
  end

  def total_time_in_minutes(layers, actual) do
    preparation_time_in_minutes(layers) + actual
  end

  def alarm do
    "Ding!"
  end
end
