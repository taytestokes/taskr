defmodule Taskr.Tasks do

    alias Taskr.Repo
    alias Taskr.Tasks.Task

    def get_tasks() do
        Repo.all(Task)
    end

    def create_task(attrs) do
        %Task{}
        |> Task.changeset(attrs)
        |> Repo.insert()
    end

    def create_changeset(%Task{} = task) do
        Task.changeset(task, %{})
    end
end