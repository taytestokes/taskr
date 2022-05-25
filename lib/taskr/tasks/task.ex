defmodule Taskr.Tasks.Task do
    use Ecto.Schema

    schema "tasks" do
        field(:description, :string)
        field(:status, :string)

        timestamps()
    end
end