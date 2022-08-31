defmodule Taskr.Repo.Migrations.AddThemeToCollections do
  use Ecto.Migration

  def change do
    alter table(:collections) do
      add :theme, :string
    end
  end
end
