defmodule Taskr.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:email, :string)
      add(:password_hash, :string)
      add(:first_name, :string)
      add(:last_name, :string)

      timestamps()
    end
  end
end
