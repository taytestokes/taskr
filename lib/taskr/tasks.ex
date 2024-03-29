defmodule Taskr.Tasks do
  import Ecto.Query

  alias Taskr.Repo
  alias Taskr.Tasks.Task

  # Get all the tasks for the current date by the user id
  def get_current_date_tasks_by_user_id(user_id) do
    current_date = NaiveDateTime.add(NaiveDateTime.utc_now(), -1)
    beginning_of_current_date = Timex.beginning_of_day(current_date)
    end_of_current_date = Timex.end_of_day(current_date)

    from(
      t in Task,
      where: t.user_id == ^user_id,
      where: t.inserted_at > ^beginning_of_current_date and t.inserted_at < ^end_of_current_date
    )
    |> order_by(asc: :id)
    |> Repo.all()
  end

  def get_task_by_id!(task_id) do
    Repo.get!(Task, task_id)
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
