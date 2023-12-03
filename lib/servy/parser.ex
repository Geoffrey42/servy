defmodule Servy.Parser do
  @moduledoc "Handles http routes parser."
  alias Servy.Conv

  def parse(request) do
    [top, params_string] = String.split(request, "\n\n")

    [request_line | header_lines] = String.split(top, "\n")
    [method, path, _] = String.split(request_line, " ")

    headers = parse_headers(header_lines)
    params = parse_params(headers["Content-Type"], params_string)

    IO.inspect(header_lines)

    %Conv{
      method: method,
      path: path,
      params: params,
      headers: headers
    }
  end

  @doc """
  Parses the given param string of the form `key1=value1&key2=value2`
  into a map with corresponding keys and values.

  ## Examples
  iex> param_string = "name=Baloo&type=Brown"
  "name=Baloo&type=Brown"
  iex> Servy.Parser.parse_params("application/x-www-form-urlencoded", param_string)
  %{"name" => "Baloo", "type" => "Brown"}
  iex> Servy.Parser.parse_params("multipart/form-data", param_string)
  %{}
  """
  def parse_params("application/x-www-form-urlencoded", params_string) do
    params_string |> String.trim() |> URI.decode_query()
  end

  def parse_params(_, _), do: %{}

  # ["Host: example.com", "User-Agent: ExampleBrowser/1.0", "Accept: */*", "Content-Type: application/x-www-form-urlencoded", "Content-Length: 21"]
  def parse_headers(header_lines) do
    Enum.reduce(header_lines, %{}, fn header, headers ->
      [key, value] = String.split(header, ": ")
      Map.put(headers, key, value)
    end)
  end
end
