defmodule Taskr.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:email, :string)
    field(:password, :string, virtual: true)
    field(:password_hash, :string)
    field(:first_name, :string)
    field(:last_name, :string)

    has_many(:tasks, Taskr.Tasks.Task)

    timestamps()
  end

  # Changesets
  def registration_changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 6)
    # Downcases the email address
    |> downcase_email()
    # Ensures the downcased email is unique in the database
    |> unique_constraint(:email)
    # Hash the password and update the password_hash field with it
    |> hash_password()
  end

  # Changeset Helpers
  defp downcase_email(changeset) do
    case get_field(changeset, :email) do
      nil -> changeset
      email -> put_change(changeset, :email, String.downcase(email))
    end
  end

  defp hash_password(changeset) do
    case changeset do
      # Pattern matches the changeset to ensure it's valid and
      # captures the password to hash and then store for the
      # password_hash column in that table
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, Argon2.hash_pwd_salt(password))

      _ ->
        changeset
    end
  end
end
