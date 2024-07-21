defmodule Forem.Repo do
  use Ecto.Repo,
    otp_app: :forem,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 10
end
