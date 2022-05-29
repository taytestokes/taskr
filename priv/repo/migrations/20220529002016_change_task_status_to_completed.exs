defmodule Taskr.Repo.Migrations.ChangeTaskStatusToCompleted do
  use Ecto.Migration

  def change do
    alter table(:tasks) do
      add(:completed, :boolean)
      remove(:status)
    end
  end
end
