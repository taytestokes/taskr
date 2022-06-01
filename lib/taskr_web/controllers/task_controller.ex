defmodule TaskrWeb.TaskController do
    use TaskrWeb, :controller

    alias Taskr.Tasks
    alias Taskr.Tasks.Task

    def index(conn, _params) do
        user_id = conn.assigns.current_user.id
        tasks = Tasks.get_tasks_by_user_id(user_id)

        # add a changeset to be used to create a new task from the index page
        changeset = Tasks.create_changeset(%Task{})

        render(conn, "index.html", tasks: tasks, changeset: changeset)
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
        # Add the current logged in users id into the task params
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

    def toggle_completion(task) do
        case task.completed do
            false -> true
            _ -> false
        end
    end

    def toggle(conn, %{"id" => id}) do
        task = Tasks.get_task_by_id!(id)

        # Update the task to be completed
        Tasks.update_task(task, %{completed: toggle_completion(task)})

        # Redirect to task index page
        redirect(conn, to: Routes.task_path(conn, :index))
    end
end