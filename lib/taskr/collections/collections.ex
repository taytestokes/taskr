defmodule Taskr.Collections.Collection do
  use Ecto.Schema
  import Ecto.Changeset

  schema "collection" do
    field(:title, :string)

    belongs_to(:user, Taskr.Users.User)

    timestamps()
  end

  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :user_id])
    |> validate_required([:title, :user_id])
  end
end
