defmodule TaskrWeb.Plugs.Auth do
    @behavior Plug

    import Plug.Conn
    import Phoenix.Controller

    alias TaskrWeb.Router.Helpers, as: Routes
    alias Taskr.Users

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
end