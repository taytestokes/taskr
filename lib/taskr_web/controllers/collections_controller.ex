defmodule TaskrWeb.CollectionsController do
  use TaskrWeb, :controller

  alias Taskr.Tasks
  alias Taskr.Tasks.Task
  alias Taskr.Collections
  alias Taskr.Collections.Collection

  def show(conn, %{"id" => collection_id}) do
    user_id = conn.assigns.current_user.id
    collections = Collections.get_collections_by_user_id(user_id)
    collection = Collections.get_collection_by_id(collection_id)
    changeset = Tasks.create_changeset(%Task{})

    render(conn, "show.html", collections: collections, collection: collection, changeset: changeset)
  end

  def new(conn, _params) do
    user_id = conn.assigns.current_user.id
    collections = Collections.get_collections_by_user_id(user_id)
    changeset = Collections.create_changeset(%Collection{})

    render(conn, "new.html", changeset: changeset, collections: collections)
  end

  def create(conn, %{"collection" => collection_params}) do
    user_id = conn.assigns.current_user.id
    # Add the current logged in users id into the collection params
    collection_params = Map.put(collection_params, "user_id", user_id)

    case Collections.create_collection(collection_params) do
      {:ok, collection} ->
        conn
        |> redirect(to: Routes.collections_path(conn, :show, collection.id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
