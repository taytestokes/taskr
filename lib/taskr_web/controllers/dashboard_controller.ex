defmodule TaskrWeb.DashboardController do
  use TaskrWeb, :controller

  alias Taskr.Tasks

  def index(conn, _params) do
    user_id = conn.assigns.current_user.id
    tasks = Tasks.get_current_date_tasks_by_user_id(user_id)

    render(conn, "index.html", tasks: tasks)
  end
end
