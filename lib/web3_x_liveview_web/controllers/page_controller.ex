defmodule Web3XLiveviewWeb.PageController do
  use Web3XLiveviewWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
