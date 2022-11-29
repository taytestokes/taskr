defmodule TaskrWeb.DashboardController do
  use TaskrWeb, :controller

  alias Taskr.Tasks
  alias Taskr.Tasks.Task

  def index(conn, _params) do
    user_id = conn.assigns.current_user.id
    tasks = Tasks.get_current_date_tasks_by_user_id(user_id)
    changeset = Tasks.create_changeset(%Task{})

    render(conn, "index.html", tasks: tasks, changeset: changeset)
  end
end
