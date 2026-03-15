defmodule HighScore do
  @default_score 0

  defdelegate new(), to: Map, as: :new
  defdelegate add_player(scores, name, score), to: Map, as: :put
  defdelegate remove_player(scores, name), to: Map, as: :delete
  defdelegate reset_score(scores, name), to: __MODULE__, as: :add_player
  defdelegate get_players(scores), to: Map, as: :keys

  def add_player(scores, name) do
    add_player(scores, name, @default_score)
  end

  def update_score(scores, name, score) do
    Map.update(scores, name, score, &(&1 + score))
  end
end
