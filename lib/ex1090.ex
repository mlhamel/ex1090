defmodule Ex1090 do
  defdelegate events, to: Ex1090.API.Events, as: :event
end
