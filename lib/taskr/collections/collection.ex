defmodule Taskr.Collections.Collection do
  use Ecto.Schema
  import Ecto.Changeset

  schema "collections" do
    field(:title, :string)
    field(:theme, :string)

    belongs_to(:user, Taskr.Users.User)
    
    has_many(:tasks, Taskr.Tasks.Task)

    timestamps()
  end

  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :theme, :user_id])
    |> validate_required([:title, :theme, :user_id])
  end
end
