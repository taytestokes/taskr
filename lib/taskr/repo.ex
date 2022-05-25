defmodule Taskr.Repo do
  use Ecto.Repo,
    otp_app: :taskr,
    adapter: Ecto.Adapters.Postgres
end
