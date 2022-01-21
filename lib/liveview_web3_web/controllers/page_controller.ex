defmodule LiveviewWeb3Web.PageController do
  use LiveviewWeb3Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
