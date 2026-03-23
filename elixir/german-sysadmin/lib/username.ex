defmodule Username do
  def sanitize(username) do
    Enum.flat_map(username, fn char ->
      case char do
        lower_case when lower_case in ?a..?z -> [lower_case]
        ?_ -> [?_]
        ?ä -> ~c"ae"
        ?ö -> ~c"oe"
        ?ü -> ~c"ue"
        ?ß -> ~c"ss"
        _disallowed -> []
      end
    end)
  end
end
