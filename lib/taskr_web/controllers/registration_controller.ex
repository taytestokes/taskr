defmodule TaskrWeb.RegistrationController do
    use TaskrWeb, :controller

    alias Taskr.Users
    alias Taskr.Users.User

    def new(conn, _params) do
        render(conn, "new.html")
    end

    def create(conn, %{"email" => email, "password" => password}) do
        case Users.create_user(%{email: email, password: password}) do
            {:ok, user} ->
                conn
                |> put_flash(:info, "User was created!")
                |> assign(:current_user, user)
                |> put_session(:user_id, user.id)
                |> configure_session(renew: true)
                |> redirect(to: Routes.task_path(conn, :index))

            {:error, _} ->
                conn
                |> put_flash(:info, "Error creating user, please try again")
                |> render("new.html")
        end
    end
end