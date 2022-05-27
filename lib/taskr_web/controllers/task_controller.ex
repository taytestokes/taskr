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
        # Get the current user id from the connection struct
        # This is assigned in the plug middleware that's ran on every connection
        user_id = conn.assigns.current_user.id
        # Update the task with the user id
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
        task  =  Tasks.get_task!(id)
        changeset = Tasks.create_changeset(task)
        render(conn, "edit.html", task: task, changeset: changeset)
    end

    def update(conn, %{"task" => task_params, "id" => id}) do
        task = Tasks.get_task!(id)

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
        task = Tasks.get_task!(id)

        case Tasks.delete_task(task) do
            {:ok, _task} ->
                conn
                |> put_flash(:info, "Task was successfully deleted!")
                |> redirect(to: Routes.task_path(conn, :index))
        end
    end
end