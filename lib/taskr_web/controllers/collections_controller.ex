defmodule TaskrWeb.CollectionsController do
  use TaskrWeb, :controller

  alias Taskr.Collections
  alias Taskr.Collections.Collection

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
        # Readjust once we have collection routes done
        |> redirect(to: Routes.dashboard_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
