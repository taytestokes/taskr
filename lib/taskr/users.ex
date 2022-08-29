defmodule Taskr.Users do
  import Ecto.Query

  alias Taskr.Repo
  alias Taskr.Users.User

  def get_user!(id), do: Repo.get!(User, id)

  def get_user_by_email(email) do
    email = String.downcase(email)

    from(
      u in User,
      where: u.email == ^email
    )
    |> Repo.one()
  end

  def create_user(attrs) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  def authenticate_user(email, password) do
    user = get_user_by_email(email)

    cond do
      user && Argon2.verify_pass(password, user.password_hash) ->
        {:ok, user}

      user ->
        {:error, :invalid_password}

      true ->
        {:error, :invalid_email}
    end
  end
end
