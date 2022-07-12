defmodule TaskrWeb.SessionController do
    use TaskrWeb, :controller

    alias Taskr.Users
    alias Taskr.Users.User

    def new(conn, _params) do
        render(conn, "new.html")
    end

    def create(conn, %{"email" => email, "password" => password}) do
        conn
        |> login_with_email_and_password(email, password)
        |> handle_login_response()
    end

    def delete(conn, _params), do: logout_user(conn)

    # Helpers
    defp logout_user(conn) do
        conn
        |> configure_session(drop: true)
        |> redirect(to: Routes.session_path(conn, :new))
    end

    defp login_user(conn, user) do
        conn
        |> assign(:current_user, user)
        |> put_session(:user_id, user.id)
        |> configure_session(renew: true)
    end

    defp login_with_email_and_password(conn, email, password) do
        case Users.authenticate_user(email, password) do
            {:ok, user} -> {:ok, login_user(conn, user)}
            {:error, reason} -> {:error, reason, conn}
        end
    end

    defp handle_login_response({:ok, conn}) do
        conn
        |> put_flash(:info, "Welcome to Taskr!")
        |> redirect(to: Routes.task_path(conn, :index))
    end
    
    defp handle_login_response({:error, :invalid_password, conn}) do
        conn
        |> put_flash(:info, "Invalid password, please try again!")
        |> render("new.html")
    end

    defp handle_login_response({:error, :invalid_email, conn}) do
        conn
        |> put_flash(:info, "Invalid email, please try again!")
        |> render("new.html")
    end
end