defmodule TaskrWeb.TaskController do
    use TaskrWeb, :controller

    alias Taskr.Tasks
    alias Taskr.Tasks.Task

    def index(conn, _params) do
        user_id = conn.assigns.current_user.id
        tasks = Tasks.get_tasks_by_user_id(user_id)
        completed_tasks = Enum.filter(tasks, fn task -> task.completed end)
        inprogress_tasks = Enum.filter(tasks, fn task -> !task.completed end)

        render(conn, "index.html", completed_tasks: completed_tasks, inprogress_tasks: inprogress_tasks)
    end

    def show(conn, %{"id" => id}) do
        task = Tasks.get_task_by_id!(id)
        render(conn, "show.html", task: task)
    end

    def new(conn, _params) do
        changeset = Tasks.create_changeset(%Task{})
        render(conn, "new.html", changeset: changeset)
    end

    def create(conn, %{"task" => task_params}) do
        user_id = conn.assigns.current_user.id
        task_params = Map.put(task_params, "user_id", user_id)

        case Tasks.create_task(task_params) do
            {:ok, _task} ->
                conn
                |> put_flash(:success, "Task created!")
                |> redirect(to: Routes.task_path(conn, :index))

            {:error, %Ecto.Changeset{} = changeset} ->
                render(conn, "new.html", changeset: changeset)
        end
    end

    def edit(conn, %{"id" => id}) do
        task  =  Tasks.get_task_by_id!(id)
        changeset = Tasks.create_changeset(task)
        render(conn, "edit.html", task: task, changeset: changeset)
    end

    def update(conn, %{"task" => task_params, "id" => id}) do
        task = Tasks.get_task_by_id!(id)

        case Tasks.update_task(task, task_params) do
            {:ok, _task} ->
                conn
                |> put_flash(:success, "Task was updated!")
                |> redirect(to: Routes.task_path(conn, :index))

            {:error, %Ecto.Changeset{} = changeset} ->
                render(conn, "edit.html", task: task, changeset: changeset)
        end
    end
    
    def delete(conn, %{"id" => id}) do
        task = Tasks.get_task_by_id!(id)

        case Tasks.delete_task(task) do
            {:ok, _task} ->
                conn
                |> put_flash(:info, "Task was successfully deleted!")
                |> redirect(to: Routes.task_path(conn, :index))
        end
    end
end