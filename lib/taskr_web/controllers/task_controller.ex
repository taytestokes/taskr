defmodule TaskrWeb.TaskController do
    use TaskrWeb, :controller

    alias Taskr.Tasks
    alias Taskr.Tasks.Task

    def index(conn, _params) do
        tasks = Tasks.get_tasks()
        render(conn, "index.html", tasks: tasks)
    end

    def new(conn, _params) do
        changeset = Tasks.create_changeset(%Task{})
        render(conn, "new.html", changeset: changeset)
    end

    def create(conn, %{"task" => task_params}) do
        case Tasks.create_task(task_params) do
            {:ok, _task} ->
                conn
                |> put_flash(:success, "Task created!")
                |> redirect(to: Routes.task_path(conn, :index))
        end
    end
end