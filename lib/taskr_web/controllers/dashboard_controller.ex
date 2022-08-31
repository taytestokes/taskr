defmodule TaskrWeb.DashboardController do
  use TaskrWeb, :controller

  alias Taskr.Collections

  def index(conn, _params) do
    user_id = conn.assigns.current_user.id
    collections = Collections.get_collections_by_user_id(user_id)
    
    render(conn, "index.html", collections: collections)
  end
end
