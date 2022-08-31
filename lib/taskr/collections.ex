defmodule Taskr.Collections do
    import Ecto.Query

    alias Taskr.Repo
    alias Taskr.Collections.Collection

    def create_collection(attrs) do
        %Collection{}
        |> Collection.changeset(attrs) 
        |> Repo.insert()
    end

    def create_changeset(%Collection{} = collection) do
        Collection.changeset(collection, %{})
    end
end
