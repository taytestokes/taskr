defmodule Taskr.Collections do
    import Ecto.Query

    alias Taskr.Repo
    alias Taskr.Collections.Collection

    def get_collection_by_id(id) do
        Repo.get!(Collection, id)
    end

    def get_collections_by_user_id(user_id) do
        from(
            c in Collection,
            where: c.user_id == ^user_id
        )
        |> order_by(asc: :id)
        |> Repo.all()
    end

    def create_collection(attrs) do
        %Collection{}
        |> Collection.changeset(attrs) 
        |> Repo.insert()
    end

    def create_changeset(%Collection{} = collection) do
        Collection.changeset(collection, %{})
    end
end
