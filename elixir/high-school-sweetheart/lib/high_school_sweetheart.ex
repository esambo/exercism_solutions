defmodule HighSchoolSweetheart do
  def first_letter(name) do
    name |> String.trim() |> String.first()
  end

  def initial(name) do
    name |> first_letter() |> String.upcase() |> Kernel.<>(".")
  end

  def initials(full_name) do
    full_name |> String.trim() |> String.split() |> Enum.map_join(" ", &(initial(&1)))
  end

  def pair(full_name1, full_name2) do
    initials1 = initials(full_name1)
    initials2 = initials(full_name2)
    """
    ❤-------------------❤
    |  #{initials1}  +  #{initials2}  |
    ❤-------------------❤
    """
  end
end
