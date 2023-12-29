defmodule HandlerTest do
  use ExUnit.Case

  alias Servy.Handler

  test "POST /api/bears" do
    request = """
    POST /api/bears HTTP/1.1
    Host: example.com
    User-Agent: ExampleBrowser/1.0
    Accept: */*
    Content-Type: application/json
    Content-Length: 21

    {"name": "Breezly", "type": "Polar"}
    """

    response = Handler.handle(request)

    assert response == """
           HTTP/1.1 201 Created\r
           Content-Type: text/html\r
           Content-Length: 35\r
           \r
           Created a Polar bear named Breezly!
           """
  end
end
