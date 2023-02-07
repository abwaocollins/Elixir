defmodule PhxPasswordGenerator.Repo do
  use Ecto.Repo,
    otp_app: :phx_password_generator,
    adapter: Ecto.Adapters.Postgres
end
