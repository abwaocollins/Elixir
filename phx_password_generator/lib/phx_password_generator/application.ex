defmodule PhxPasswordGenerator.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      PhxPasswordGenerator.Repo,
      # Start the Telemetry supervisor
      PhxPasswordGeneratorWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: PhxPasswordGenerator.PubSub},
      # Start the Endpoint (http/https)
      PhxPasswordGeneratorWeb.Endpoint
      # Start a worker by calling: PhxPasswordGenerator.Worker.start_link(arg)
      # {PhxPasswordGenerator.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhxPasswordGenerator.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhxPasswordGeneratorWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
