defmodule TaskrWeb.CollectionsController do
  use TaskrWeb, :controller

  def new(conn, _params) do
    render(conn, "new.html")
  end
end
