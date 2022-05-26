defmodule Taskr.Tasks do

    alias Taskr.Repo
    alias Taskr.Tasks.Task

    def get_task!(id) do
        Repo.get!(Task, id)
    end

    def get_tasks() do
        Repo.all(Task)
    end

    def create_task(attrs) do
        %Task{}
        |> Task.changeset(attrs)
        |> Repo.insert()
    end

    def delete_task(%Task{} = task) do
        Repo.delete(task)
    end

    def create_changeset(%Task{} = task) do
        Task.changeset(task, %{})
    end
end