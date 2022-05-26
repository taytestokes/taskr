defmodule Taskr.Tasks.Task do
    use Ecto.Schema
    import Ecto.Changeset

    schema "tasks" do
        field(:description, :string)
        field(:status, :string)

        timestamps()
    end

    def changeset(task, attrs) do
        task
        |> cast(attrs, [:description])
        |> validate_required([:description])
  end
end