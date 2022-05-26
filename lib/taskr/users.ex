defmodule Taskr.Users do

    alias Taskr.Repo
    alias Taskr.Users.User
    
    def create_user(attrs) do
        %User{}
        |> User.registration_changeset(attrs)
        |> Repo.insert()
    end
end