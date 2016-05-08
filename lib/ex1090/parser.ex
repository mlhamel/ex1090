defmodule Ex1090.Parser do
  def parse_event(object) do
    struct(Ex1090.Model.Event, object)
  end
end
