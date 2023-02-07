defmodule PhxPasswordGeneratorWeb.Api.PageControllerTest do
  use PhxPasswordGeneratorWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "generates a password" do
    test "generates password with only length passed", %{conn: conn} do
      conn = post(conn, Routes.page_path(conn, :api_generate), %{"length" => "5"})
      assert %{"password" => _pass} = json_response(conn, 200)
    end

    test "generates password with only one option", %{conn: conn} do
      options = %{"length" => "5", "numbers" => "true"}

      conn = post(conn, Routes.page_path(conn, :api_generate), options)

      assert %{"password" => _pass} = json_response(conn, 200)
    end
  end

  describe "returns errors" do
    test "errors when no option are provided", %{conn: conn} do
      conn = post(conn, Routes.page_path(conn, :api_generate), %{})
      assert %{"error" => _error} = json_response(conn, 200)
    end

    test "errors when length not an integer", %{conn: conn} do
      conn = post(conn, Routes.page_path(conn, :api_generate), %{"length" => "ab"})
      assert %{"error" => _error} = json_response(conn, 200)
    end

    test "errors when options are not boolean", %{conn: conn} do
      options = %{"length" => "5", "invalid" => "invalid"}

      conn = post(conn, Routes.page_path(conn, :api_generate), options)

      assert %{"error" => _error} = json_response(conn, 200)
    end

    test "errors with invalid option key", %{conn: conn} do
      options = %{"length" => "5", "invalid" => "true"}

      conn = post(conn, Routes.page_path(conn, :api_generate), options)

      assert %{"error" => _error} = json_response(conn, 200)
    end
  end
end
