defmodule Taskr.Repo.Migrations.DropCollectionsTable do
  use Ecto.Migration

  def change do
    drop table("collections"), mode: :cascade

    alter table("tasks") do
      remove :collection_id
    end
  end
end
