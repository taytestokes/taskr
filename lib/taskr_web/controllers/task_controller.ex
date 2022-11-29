defmodule TaskrWeb.TaskController do
  use TaskrWeb, :controller

  alias Taskr.Tasks
  alias Taskr.Tasks.Task

  def index(conn, _params) do
    user_id = conn.assigns.current_user.id
    tasks = Tasks.get_tasks_by_user_id(user_id)
    changeset = Tasks.create_changeset(%Task{})

    render(conn, "index.html", tasks: tasks, changeset: changeset)
  end

  def create(conn, %{"task" => task_params}) do
    user_id = conn.assigns.current_user.id
    # Add user id to task params
    task_params = Map.put(task_params, "user_id", user_id)

    case Tasks.create_task(task_params) do
      {:ok, _task} ->
        conn
        |> put_flash(:success, "Task created!")
        |> redirect(to: Routes.dashboard_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(TaskrWeb.DashboardView, "index.html", changeset: changeset)
    end
  end

  def toggle(conn, %{"task_id" => task_id}) do
    # Get task from database
    task = Tasks.get_task_by_id!(task_id)
    # Update task toggling the completion status
    Tasks.update_task(task, %{completed: !task.completed})
    # Redirect to collection page that task belongs to
    redirect(conn, to: Routes.dashboard_path(conn, :index))
  end

  # MAYBE?
  def edit(conn, %{"id" => id}) do
    task = Tasks.get_task_by_id!(id)
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

  def delete(conn, %{"collection_id" => collection_id, "task_id" => task_id}) do
    task = Tasks.get_task_by_id!(task_id)

    case Tasks.delete_task(task) do
      {:ok, _task} ->
        conn
        |> put_flash(:info, "Task was successfully deleted!")
        |> redirect(to: Routes.collections_path(conn, :show, collection_id))
    end
  end
end
