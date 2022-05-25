defmodule TaskrWeb.PageController do
  use TaskrWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
