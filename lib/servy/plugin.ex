defmodule Servy.Plugins do
  @moduledoc "Handles plugins."

  alias Servy.Conv

  require Logger

  @doc "Logs 404 requests"
  def track(%Conv{status: 404, path: path} = conv) do
    Logger.warning("#{path} is on the loose!")
    conv
  end

  def track(%Conv{} = conv), do: conv

  def rewrite_path(%Conv{path: "/bears?id=" <> id_number} = conv) do
    %{conv | path: "/bears/#{id_number}"}
  end

  def rewrite_path(%Conv{path: "/wildlife"} = conv) do
    %{conv | path: "/wildthings"}
  end

  def rewrite_path(%Conv{} = conv), do: conv

  def log(%Conv{} = conv), do: IO.inspect(conv)
end
