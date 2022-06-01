defmodule Taskr.Repo.Migrations.AddTitleToTasks do
  use Ecto.Migration

  def change do
    alter table(:tasks) do
      add(:title, :string)
    end
  end
end
