defmodule Forem.Repo do
  use Ecto.Repo,
    otp_app: :forem,
    adapter: Ecto.Adapters.Postgres
end
