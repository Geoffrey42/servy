defmodule Servy.HttpClient do
  def client() do
    someHostInNet = 'localhost'
    {:ok, sock} = :gen_tcp.connect(someHostInNet, 4000, [:binary, packet: :raw, active: false])

    request = """
    POST /bears HTTP/1.1\r
    Host: example.com\r
    User-Agent: ExampleBrowser/1.0\r
    Accept: */*\r
    Content-Type: application/x-www-form-urlencoded\r
    Content-Length: 21\r
    \r
    name=Baloo&type=Brown
    """

    :ok = :gen_tcp.send(sock, request)
    {:ok, response} = :gen_tcp.recv(sock, 0)

    :ok = :gen_tcp.close(sock)

    response
  end
end
