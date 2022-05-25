defmodule Taskr.Tasks do

    alias Taskr.Repo
    alias Taskr.Tasks.Task

    def create_task() do
        %Task{}
        |> Repo.insert()
    end
end