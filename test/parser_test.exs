defmodule ParserTest do
  use ExUnit.Case
  doctest Servy.Parser

  alias Servy.Parser

  test "should parse header_lines" do
    given_header_lines = [
      "Host: example.com",
      "User-Agent: ExampleBrowser/1.0",
      "Content-Length: 21"
    ]

    expected_headers = %{
      "Host" => "example.com",
      "User-Agent" => "ExampleBrowser/1.0",
      "Content-Length" => "21"
    }

    headers = Parser.parse_headers(given_header_lines)

    assert expected_headers == headers
  end
end
