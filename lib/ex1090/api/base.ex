defmodule Ex1090.API.Base do
  alias Ex1090.Config

  @base_url "http://127.0.0.1:8080"

  def get(url_part, token, params \\ []) do
    [url_part, params]
    |> build_url(token)
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

  defp build_url([part, []], :global) do
    config = Config.get
    string = if config.access_token, do: "access_token=#{config.access_token}", else:  "client_id=#{config.client_id}"

    "#{@base_url}#{part}?#{string}"
  end
  defp build_url([part, []], token) do
    "#{@base_url}#{part}?access_token=#{token}"
  end

  defp build_url([part, params], :global) do
    config = Config.get
    auth_param = if config.access_token, do: ["access_token", config.access_token], else:  ["client_id", config.client_id]
    params_with_auth = [auth_param|params]
    "#{@base_url}#{part}?#{params_join(params_with_auth)}"
  end
  defp build_url([part, params], token) do
    params_with_auth = [["access_token", token]|params]
    "#{@base_url}#{part}?#{params_join(params_with_auth)}"
  end

  defp params_join(params) do
    params_join(params, "")
  end
  defp params_join([h | []], string) do
    [param, value] = h
    string <> "&#{param}=#{value}"
  end
  defp params_join([h | t], "") do
    [param | value] = h
    params_join(t, "#{param}=#{value}")
  end
  defp params_join([h | t], string) do
    [param | value] = h
    params_join(t, string<>"&#{param}=#{value}")
  end
end
