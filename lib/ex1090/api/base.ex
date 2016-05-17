defmodule Ex1090.API.Base do
  alias Ex1090.Config

  @base_url "http://127.0.0.1:8080"

  def get(path) do
    "#{@base_url}#{path}"
    |> HTTPoison.get!
    |> handle_response
  end

  defp handle_response(data) do
    response = Poison.decode!(data.body, keys: :atoms)
    case response.meta.code do
      200 -> response
      _ -> raise(Ex1090.Error, [code: response.meta.code, message: "#{response.meta.error_type}: #{response.meta.error_message}"])
    end
  end
end
