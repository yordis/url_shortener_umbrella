defmodule Umbrella.Repo do
  use Ecto.Repo,
    otp_app: :umbrella,
    adapter: Ecto.Adapters.Postgres
end
