defmodule Taskr.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field(:title, :string)
    field(:completed, :boolean, default: false)

    belongs_to(:user, Taskr.Users.User)
    # belongs_to(:user, Taskr.Users.User)

    timestamps()
  end

  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :completed, :user_id])
    |> validate_required([:title, :completed, :user_id])
  end
end
