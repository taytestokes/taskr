defmodule Taskr.Tasks.Task do
    use Ecto.Schema
    import Ecto.Changeset

    schema "tasks" do
        field(:description, :string)
        field(:status, :string, default: "inprogress")

        belongs_to(:user, Taskr.Users.User)

        timestamps()
    end

    def changeset(task, attrs) do
        task
        |> cast(attrs, [:description, :user_id])
        |> validate_required([:description, :user_id])
  end
end