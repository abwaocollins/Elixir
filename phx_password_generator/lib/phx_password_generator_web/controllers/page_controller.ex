defmodule PhxPasswordGeneratorWeb.PageController do
  use PhxPasswordGeneratorWeb, :controller
  alias PhxPasswordGenerator.PassGenerator

  def index(conn, _params, password_lengths) do
    password = ""

    render(conn, "index.html", password_lengths: password_lengths, password: password)
  end

  def generate(conn, %{"password" => password_params}, password_lengths) do
    {:ok, password} = PassGenerator.generate(password_params)

    render(conn, "index.html", password_lengths: password_lengths, password: password)
  end

  def action(conn, _) do
    password_lengths = [
      weak: Enum.map(6..15, & &1),
      strong: Enum.map(16..88, & &1),
      unbelievable: [100, 150]
    ]

    args = [conn, conn.params, password_lengths]

    apply(__MODULE__, action_name(conn), args)
  end
end
