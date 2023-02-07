defmodule PhxPasswordGeneratorWeb.Api.PageController do
  use PhxPasswordGeneratorWeb, :controller

  def api_generate(conn, params) do
    case PhxPasswordGenerator.PassGenerator.generate(params) do
      {:ok, pass} -> json(conn, %{password: pass})
      {:error, error} -> json(conn, %{error: error})
    end
  end
end
