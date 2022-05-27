defmodule Taskr.Repo.Migrations.AddIndexToTaskId do
  use Ecto.Migration

  def change do
    create(index(:tasks, [:user_id]))
  end
end
