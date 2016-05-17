defmodule Ex1090.API.Events do
  import Ex1090.API.Base
  import Ex1090.Parser

  def events do
    get("/data.json").data |> Enum.map(&parse_event/1)
  end
end
