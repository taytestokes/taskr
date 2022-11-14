defmodule TaskrWeb.DashboardController do
  use TaskrWeb, :controller

  def index(conn, _params) do
    user_id = conn.assigns.current_user.id
    # TODO: Move to a date based program rather than a collection based
    # - Want tasks to be data based
    
    render(conn, "index.html")
  end
end
