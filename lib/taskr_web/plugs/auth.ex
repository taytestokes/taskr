defmodule TaskrWeb.Plugs.Auth do
    @behavior Plug

    import Plug.Conn
    import Phoenix.Controller

    alias TaskrWeb.Router.Helpers, as: Routes
    alias Taskr.Users

    # Init and Call are callbacks used at the module level for
    # implementing the plug behavior
    def init(opts), do: opts

    def call(conn, _opts) do
        user_id = get_session(conn, :user_id)

        cond do
            user = user_id && Users.get_user!(user_id) ->
                assign(conn, :current_user, user)
            
            true ->
                assign(conn, :current_user, nil)
        end
    end

    # Function level plugs
    def is_authenticated(conn, _opts) do
        cond do
            conn.assigns.current_user ->
                conn

            true ->
                conn
                |> put_flash(:error, "You must login first!")
                |> redirect(to: Routes.auth_path(conn, :new))
                |> halt()
        end
    end
end