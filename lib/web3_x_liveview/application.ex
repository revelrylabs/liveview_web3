defmodule Web3XLiveview.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Web3XLiveview.Repo,
      # Start the Telemetry supervisor
      Web3XLiveviewWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Web3XLiveview.PubSub},
      # Start Presence
      Web3XLiveviewWeb.Presence,
      # Start the Endpoint (http/https)
      Web3XLiveviewWeb.Endpoint
      # Start a worker by calling: Web3XLiveview.Worker.start_link(arg)
      # {Web3XLiveview.Worker, arg}
    ]

    # Start Web3x Contract link
    Web3x.Contract.start_link()
    # Register all contracts with Web3x so we can access them
    Web3XLiveview.SmartContracts.register_all()

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Web3XLiveview.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    Web3XLiveviewWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
