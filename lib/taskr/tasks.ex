defmodule Taskr.Tasks do
  import Ecto.Query

  alias Taskr.Repo
  alias Taskr.Tasks.Task

  def get_task_by_id!(id) do
    Repo.get!(Task, id)
  end

  def get_tasks_by_collection_id(collection_id) do
    from(
      t in Task,
      where: t.collection_id == ^collection_id
    )
    |> order_by(asc: :id)
    |> Repo.all()
  end

  def get_tasks_by_user_id(user_id) do
    from(
      t in Task,
      where: t.user_id == ^user_id
    )
    |> order_by(asc: :id)
    |> Repo.all()
  end

  def create_task(attrs) do
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end

  def update_task(%Task{} = task, attrs) do
    task
    |> Task.changeset(attrs)
    |> Repo.update()
  end

  def delete_task(%Task{} = task) do
    Repo.delete(task)
  end

  def create_changeset(%Task{} = task) do
    Task.changeset(task, %{})
  end
end
