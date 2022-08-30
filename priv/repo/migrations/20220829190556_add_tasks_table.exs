defmodule Taskr.Repo.Migrations.AddTasksTable do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add(:title, :string)

      add(:completed, :boolean)

      add(:user_id, references(:users, on_delete: :delete_all))
      add(:collection_id, references(:collections, on_delete: :delete_all))

      timestamps()
    end
  end
end
